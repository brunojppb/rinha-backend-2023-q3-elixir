defmodule RinhaElixir.Repo.Migrations.CreatePessoas do
  use Ecto.Migration

  def change do
    create table(:pessoas, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :apelido, :string
      add :nome, :string
      add :nascimento, :string
      add :stack, {:array, :string}
    end

    create unique_index(:pessoas, [:apelido])
  end
end
