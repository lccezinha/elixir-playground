defmodule Example.Router do
  use Plug.Router
  use Plug.ErrorHandler

  alias Example.Plug.VerifyRequest

  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
  plug(
    VerifyRequest,
    fields: ["content", "mimetype"],
    paths: ["/upload"]
  )
  plug(:match)
  plug(:dispatch)

  get("/", do: send_resp(conn, 200, "Welcome"))
  post("/upload", do: send_resp(conn, 201, "Uploaded\n"))
  get(_, do: send_resp(conn, 404, "Ops! Some shit happen!"))
end
