defmodule Backendcm.Repo do
  use Ecto.Repo,
    otp_app: :backendcm,
    adapter: Ecto.Adapters.Postgres
end
