defmodule RinhaElixirWeb.PessoaJSON do
  alias RinhaElixir.Cadastro.Pessoa

  @doc """
  Renders a list of pessoas.
  """
  def index(%{pessoas: pessoas}) do
    for(pessoa <- pessoas, do: data(pessoa))
  end

  @doc """
  Renders a single pessoa.
  """
  def show(%{pessoa: pessoa}) do
    data(pessoa)
  end

  defp data(%Pessoa{} = pessoa) do
    %{
      id: pessoa.id,
      apelido: pessoa.apelido,
      nome: pessoa.nome,
      nascimento: pessoa.nascimento,
      stack: pessoa.stack
    }
  end
end
