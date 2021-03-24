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

  get "/movie/:code" do
    conn.params
    |> Map.get("code")
    |> String.to_integer
    |> Controller.get_movie_by_code()
    |> build_response(conn)
  end

  post "/movie" do
    body = conn.body_params
    %Movie{code: body["code"], title: body["title"],author: body["author"]}
    |> Controller.save_movie()
    |> build_response(conn)
  end

  delete "/movie/:code" do
    conn.params
    |> Map.get("code")
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

  def build_response({:ok, response}, conn) do
    build_response(%{status: 200, body: Poison.encode!(response)}, conn)
  end

  def build_response({:error, response}, conn) do
    build_response(%{status: 400, body: Poison.encode!(response)}, conn)
  end

end
