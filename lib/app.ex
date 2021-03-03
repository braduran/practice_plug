defmodule App do
  use Application
  require Logger
  alias Movies.Repositories.Repo

  def start(_type, _args) do
    port = Application.get_env(:example, :cowboy_port, 8085)
    children = [
      {Plug.Cowboy, scheme: :http, plug: Movies.Route.Endpoint, options: [port: port]},
      {Repo, []}
    ]

    opts = [strategy: :one_for_one, name: App.Supervisor]
    Logger.info("Started application in port: #{port}")
    Supervisor.start_link(children, opts)
  end
end
