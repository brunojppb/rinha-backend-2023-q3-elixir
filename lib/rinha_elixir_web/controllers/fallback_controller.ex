defmodule RinhaElixirWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use RinhaElixirWeb, :controller
  require Logger

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    status_code = if has_invalid_fields?(changeset), do: :bad_request, else: :unprocessable_entity

    conn
    |> put_status(status_code)
    |> put_view(json: RinhaElixirWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: RinhaElixirWeb.ErrorHTML, json: RinhaElixirWeb.ErrorJSON)
    |> render(:"404")
  end

  defp has_invalid_fields?(changeset) do
    Enum.any?(changeset.errors, fn {_field, {error_msg, _}} ->
      error_msg == "is invalid"
    end)
  end
end
