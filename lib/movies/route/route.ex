defmodule Movies.Route.Route do
  alias Movies.Controller.Controller
  alias Movies.Repositories.HealthIndicator
  alias Movies.Repositories.Movie

  use Plug.Router
  require Logger

  plug(:match)
  plug(Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Poison)
  plug(:dispatch)
  plug(Plug.Session, store: :ets, key: "sid", table: :session)

  get "/health" do
    HealthIndicator.health()
    |> build_response(conn)
  end

  get "/movies" do
    Controller.get_all_movies()
    |> build_response(conn)
  end

  post "/movie" do
    get_movie(conn.body_params, "save")
    |> Controller.save_movie()
    |> build_response(conn)
  end

  delete "/movie/:id" do
    conn.params
    |> Map.get("id")
    |> String.to_integer
    |> Controller.delete_movie()
    |> build_response(conn)
  end

  match(_, do: send_resp(conn, 400, "Oops!"))

  def build_response(%{status: status, body: body}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, body)
  end

  def build_response(response, conn) do
    build_response(%{status: 200, body: Poison.encode!(response)}, conn)
  end

  def get_movie(body, op) do
    case op do
      "save" -> %Movie{code: body["code"], title: body["title"],author: body["author"]}
      "delete" -> %Movie{id: body["id"]}
      _ -> %Movie{}
    end

  end

end
