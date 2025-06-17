defmodule BackendcmWeb.Router do
  use BackendcmWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BackendcmWeb.Plugs.Auth
  end

  scope "/api/auth", BackendcmWeb do
    pipe_through :api

    post "/register", UserController, :register
    post "/login", UserController, :login
  end

  scope "/api", BackendcmWeb do
    pipe_through [:api, :auth]

    resources "/tasks", TaskController, except: [:new, :edit]
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:backendcm, :dev_routes) do

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
