defmodule BackendcmWeb.UserController do
  use BackendcmWeb, :controller
  alias Backendcm.Accounts
  alias BackendcmWeb.Auth.JWT

  def register(conn, %{"email" => email, "password" => password}) do
    case Accounts.register_user(%{"email" => email, "password" => password}) do
      {:ok, user} ->
        {:ok, token, _claims} = JWT.generate_token(user)
        json(conn, %{user: %{id: user.id, email: user.email}, token: token})

      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: changeset_errors(changeset)})
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        {:ok, token, _claims} = JWT.generate_token(user)
        json(conn, %{user: %{id: user.id, email: user.email}, token: token})

      _ ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid credentials"})
    end
  end

  defp changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, val}, acc ->
        String.replace(acc, "%{#{key}}", to_string(val))
      end)
    end)
  end
end
