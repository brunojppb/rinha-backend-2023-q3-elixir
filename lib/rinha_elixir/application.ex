defmodule RinhaElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = [
      rinha: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]

    children = [
      {Cluster.Supervisor, [topologies, [name: RinhaElixir.ClusterSupervisor]]},
      # Start the Telemetry supervisor
      RinhaElixirWeb.Telemetry,
      # Start the Ecto repository
      RinhaElixir.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: RinhaElixir.PubSub},
      # Start Finch
      {Finch, name: RinhaElixir.Finch},
      # Start the Endpoint (http/https)
      RinhaElixirWeb.Endpoint
      # Start a worker by calling: RinhaElixir.Worker.start_link(arg)
      # {RinhaElixir.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RinhaElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RinhaElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
