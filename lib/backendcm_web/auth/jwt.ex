defmodule BackendcmWeb.Auth.JWT do
  use Joken.Config

  @signer Joken.Signer.create("HS256", "super_secret_key")

  @impl true
  def token_config do
    # Define expiração automática para 24h
    default_claims(skip: [:aud, :iss, :jti, :nbf], ttl: {24, :hour})
  end

  def signer, do: @signer

  def generate_token(user) do
    generate_and_sign(%{"user_id" => user.id}, @signer)
  end
end
