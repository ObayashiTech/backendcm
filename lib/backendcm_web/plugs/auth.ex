defmodule BackendcmWeb.Plugs.Auth do
  import Plug.Conn
  alias BackendcmWeb.Auth.JWT

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, %{"user_id" => user_id}} <- JWT.verify_and_validate(token, JWT.signer()) do
      assign(conn, :current_user_id, user_id)
    else
      _ ->
        conn
        |> send_resp(401, "Unauthorized")
        |> halt()
    end
  end
end
