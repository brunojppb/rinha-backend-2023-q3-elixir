defmodule RinhaElixir.Cadastro do
  @moduledoc """
  The Cadastro context.
  """

  use Nebulex.Caching

  import Ecto.Query, warn: false
  alias RinhaElixir.Repo

  alias RinhaElixir.Cadastro.Pessoa

  @doc """
  Returns the list of pessoas.

  ## Examples

      iex> list_pessoas()
      [%Pessoa{}, ...]

  """
  def list_pessoas do
    Repo.all(Pessoa)
  end

  @doc """
  Gets a single pessoa.

  Raises `Ecto.NoResultsError` if the Pessoa does not exist.

  ## Examples

      iex> get_pessoa!(123)
      %Pessoa{}

      iex> get_pessoa!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pessoa!(id), do: Repo.get!(Pessoa, id)

  def find_pessoa(id) do
    if value = RinhaElixir.Cache.get(id) do
      value
    else
      case Repo.get(Pessoa, id) do
        nil ->
          nil

        pessoa ->
          :ok = RinhaElixir.Cache.put(id, pessoa)
          pessoa
      end
    end
  end

  @doc """
  Creates a pessoa.

  ## Examples

      iex> create_pessoa(%{field: value})
      {:ok, %Pessoa{}}

      iex> create_pessoa(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pessoa(attrs \\ %{}) do
    %Pessoa{}
    |> Pessoa.changeset(attrs)
    |> Repo.insert()
  end

  def count() do
    Pessoa.count_query()
    |> Repo.one()
  end

  def search_pessoas(filter) do
    query = Pessoa.search_query()
    filter = "%#{String.replace(filter, "%", "") |> String.downcase()}%"

    {:ok, %Postgrex.Result{rows: rows}} =
      Ecto.Adapters.SQL.query(RinhaElixir.Repo, query, [filter])

    Enum.map(rows, fn [_id, {id, nome, apelido, nascimento, stack} | _tail] ->
      RinhaElixir.Repo.load(Pessoa, %{
        id: id,
        nome: nome,
        apelido: apelido,
        nascimento: nascimento,
        stack: stack
      })
    end)
  end

  @doc """
  Updates a pessoa.

  ## Examples

      iex> update_pessoa(pessoa, %{field: new_value})
      {:ok, %Pessoa{}}

      iex> update_pessoa(pessoa, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pessoa(%Pessoa{} = pessoa, attrs) do
    pessoa
    |> Pessoa.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pessoa.

  ## Examples

      iex> delete_pessoa(pessoa)
      {:ok, %Pessoa{}}

      iex> delete_pessoa(pessoa)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pessoa(%Pessoa{} = pessoa) do
    Repo.delete(pessoa)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pessoa changes.

  ## Examples

      iex> change_pessoa(pessoa)
      %Ecto.Changeset{data: %Pessoa{}}

  """
  def change_pessoa(%Pessoa{} = pessoa, attrs \\ %{}) do
    Pessoa.changeset(pessoa, attrs)
  end
end
