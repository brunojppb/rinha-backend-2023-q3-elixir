defmodule RinhaElixir.CadastroFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RinhaElixir.Cadastro` context.
  """

  @doc """
  Generate a unique pessoa apelido.
  """
  def unique_pessoa_apelido, do: "some apelido#{System.unique_integer([:positive])}"

  @doc """
  Generate a pessoa.
  """
  def pessoa_fixture(attrs \\ %{}) do
    {:ok, pessoa} =
      attrs
      |> Enum.into(%{
        stack: ["option1", "option2"],
        apelido: unique_pessoa_apelido(),
        nome: "some nome",
        nascimento: "some nascimento"
      })
      |> RinhaElixir.Cadastro.create_pessoa()

    pessoa
  end
end
