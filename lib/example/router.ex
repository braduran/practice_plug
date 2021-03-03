defmodule Example.Router do
  use Plug.Router
  use Plug.ErrorHandler
  require Logger

  alias Example.Plug.VerifyRequest

  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
  plug(
    VerifyRequest,
    fields: ["content", "mimetype"],
    paths: ["/upload"]
  )
  plug(:match)
  plug(:dispatch)
  plug(Plug.Logger)

  get("/hello/:name", do: send_resp(conn, 200, "Hello, #{name}"))
  post "/upload" do
    put_resp_content_type(conn, "application/json")
    |> send_resp(201, "Uploaded")
  end

  post("/test", do: send_resp(conn, 201, "test"))

  match(_, do: send_resp(conn, 400, "Oops!"))
end
