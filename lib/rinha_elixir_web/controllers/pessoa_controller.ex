defmodule RinhaElixirWeb.PessoaController do
  use RinhaElixirWeb, :controller

  alias RinhaElixir.Cadastro
  alias RinhaElixir.Cadastro.Pessoa

  action_fallback RinhaElixirWeb.FallbackController

  def index(conn, _params) do
    pessoas = Cadastro.list_pessoas()
    render(conn, :index, pessoas: pessoas)
  end

  def create(conn, %{"pessoa" => pessoa_params}) do
    case Cadastro.create_pessoa(pessoa_params) do
      {:ok, %Pessoa{} = pessoa} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/pessoas/#{pessoa}")
        |> render(:show, pessoa: pessoa)

      {:error, changeset} ->
        RinhaElixirWeb.FallbackController.call(conn, {:error, changeset})
    end
  end

  def show(conn, %{"id" => id}) do
    pessoa = Cadastro.get_pessoa!(id)
    render(conn, :show, pessoa: pessoa)
  end

  def update(conn, %{"id" => id, "pessoa" => pessoa_params}) do
    pessoa = Cadastro.get_pessoa!(id)

    with {:ok, %Pessoa{} = pessoa} <- Cadastro.update_pessoa(pessoa, pessoa_params) do
      render(conn, :show, pessoa: pessoa)
    end
  end

  def delete(conn, %{"id" => id}) do
    pessoa = Cadastro.get_pessoa!(id)

    with {:ok, %Pessoa{}} <- Cadastro.delete_pessoa(pessoa) do
      send_resp(conn, :no_content, "")
    end
  end
end
