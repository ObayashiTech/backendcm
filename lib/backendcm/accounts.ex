defmodule Backendcm.Accounts do
  alias Backendcm.Accounts.User
  alias Backendcm.Repo
  import Ecto.Query

  import Bcrypt, only: [verify_pass: 2]

  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_user(email, password) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :unauthorized}
      user ->
        if verify_pass(password, user.password_hash),
          do: {:ok, user},
          else: {:error, :unauthorized}
    end
  end
end
