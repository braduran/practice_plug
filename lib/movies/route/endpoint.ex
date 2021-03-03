defmodule Movies.Route.Endpoint do
  use Plug.Router

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  forward("/api", to: Movies.Route.Route)

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

end
