defmodule RinhaElixir.Repo do
  use Ecto.Repo,
    otp_app: :rinha_elixir,
    adapter: Ecto.Adapters.Postgres
end
