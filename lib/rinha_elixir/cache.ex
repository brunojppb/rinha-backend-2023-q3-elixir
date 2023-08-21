defmodule RinhaElixir.Cache do
  use Nebulex.Cache,
    otp_app: :rinha_elixir,
    adapter: Nebulex.Adapters.Replicated,
    primary_storage_adapter: Nebulex.Adapters.Local
end
