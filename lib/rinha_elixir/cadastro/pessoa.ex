defmodule RinhaElixir.Cadastro.Pessoa do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "pessoas" do
    field :apelido, :string
    field :nome, :string
    field :nascimento, :string
    field :stack, {:array, :string}
  end

  @doc false
  def changeset(pessoa, attrs) do
    pessoa
    |> cast(attrs, [:apelido, :nome, :nascimento, :stack])
    |> validate_required([:apelido, :nome, :nascimento])
    |> validate_length(:apelido, max: 100)
    |> validate_length(:nome, max: 32)
    |> validate_format(:nascimento, ~r/^\d{4}\-\d{2}\-\d{2}$/,
      message: "Invalid format for field nascimento"
    )
    |> validate_stack(:stack)
    |> unique_constraint(:apelido)
  end

  defp validate_stack(changeset, field) do
    # This is only invoked if a change for the field is given.
    # null or undefined values given by controllers that don't touch the changeset
    # will not trigger the changeset validation
    validate_change(changeset, field, fn _, values ->
      # If a list is given, it must contain at least one element
      is_valid_optional_list = if is_list(values), do: length(values) > 0, else: true

      if !is_valid_optional_list do
        [{field, "is invalid"}]
      else
        # All values must be strings with a max length of 32 chars
        is_stack_valid =
          Enum.all?(values, fn value ->
            is_binary(value) && String.length(value) <= 32
          end)

        if is_stack_valid do
          []
        else
          [{field, "is invalid"}]
        end
      end
    end)
  end
end
