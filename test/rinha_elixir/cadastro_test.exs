defmodule RinhaElixir.CadastroTest do
  use RinhaElixir.DataCase

  alias RinhaElixir.Cadastro

  describe "pessoas" do
    alias RinhaElixir.Cadastro.Pessoa

    import RinhaElixir.CadastroFixtures

    @invalid_attrs %{stack: nil, apelido: nil, nome: nil, nascimento: nil}

    test "list_pessoas/0 returns all pessoas" do
      pessoa = pessoa_fixture()
      assert Cadastro.list_pessoas() == [pessoa]
    end

    test "get_pessoa!/1 returns the pessoa with given id" do
      pessoa = pessoa_fixture()
      assert Cadastro.get_pessoa!(pessoa.id) == pessoa
    end

    test "create_pessoa/1 with valid data creates a pessoa" do
      valid_attrs = %{stack: ["option1", "option2"], apelido: "some apelido", nome: "some nome", nascimento: "some nascimento"}

      assert {:ok, %Pessoa{} = pessoa} = Cadastro.create_pessoa(valid_attrs)
      assert pessoa.stack == ["option1", "option2"]
      assert pessoa.apelido == "some apelido"
      assert pessoa.nome == "some nome"
      assert pessoa.nascimento == "some nascimento"
    end

    test "create_pessoa/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cadastro.create_pessoa(@invalid_attrs)
    end

    test "update_pessoa/2 with valid data updates the pessoa" do
      pessoa = pessoa_fixture()
      update_attrs = %{stack: ["option1"], apelido: "some updated apelido", nome: "some updated nome", nascimento: "some updated nascimento"}

      assert {:ok, %Pessoa{} = pessoa} = Cadastro.update_pessoa(pessoa, update_attrs)
      assert pessoa.stack == ["option1"]
      assert pessoa.apelido == "some updated apelido"
      assert pessoa.nome == "some updated nome"
      assert pessoa.nascimento == "some updated nascimento"
    end

    test "update_pessoa/2 with invalid data returns error changeset" do
      pessoa = pessoa_fixture()
      assert {:error, %Ecto.Changeset{}} = Cadastro.update_pessoa(pessoa, @invalid_attrs)
      assert pessoa == Cadastro.get_pessoa!(pessoa.id)
    end

    test "delete_pessoa/1 deletes the pessoa" do
      pessoa = pessoa_fixture()
      assert {:ok, %Pessoa{}} = Cadastro.delete_pessoa(pessoa)
      assert_raise Ecto.NoResultsError, fn -> Cadastro.get_pessoa!(pessoa.id) end
    end

    test "change_pessoa/1 returns a pessoa changeset" do
      pessoa = pessoa_fixture()
      assert %Ecto.Changeset{} = Cadastro.change_pessoa(pessoa)
    end
  end
end
