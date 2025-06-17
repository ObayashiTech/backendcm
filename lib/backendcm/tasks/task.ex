defmodule Backendcm.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :title, :string
    field :done, :boolean, default: false

    belongs_to :user, Backendcm.Accounts.User

    timestamps()
  end

  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :done, :user_id])
    |> validate_required([:title, :done, :user_id])
  end
end
