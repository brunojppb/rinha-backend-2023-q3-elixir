defmodule RinhaElixirWeb.PessoaController do
  use RinhaElixirWeb, :controller

  alias RinhaElixir.Cadastro
  alias RinhaElixir.Cadastro.Pessoa

  action_fallback RinhaElixirWeb.FallbackController

  def index(conn, params) do
    case params do
      %{"t" => filter} ->
        if String.length(filter) > 0 do
          pessoas = Cadastro.search_pessoas(filter)
          render(conn, :index, pessoas: pessoas)
        else
          conn
          |> send_resp(:bad_request, "Invalid filter 't'")
        end

      _ ->
        conn
        |> send_resp(:bad_request, "Invalid filter 't'")
    end
  end

  def count(conn, _params) do
    count = Cadastro.count()

    conn
    |> send_resp(:ok, "#{count}")
  end

  def create(conn, pessoa_params) do
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
