defmodule Backendcm.Tasks do
  alias Backendcm.Tasks.Task
  alias Backendcm.Repo
  import Ecto.Query

  def list_tasks(user_id) do
    Repo.all(from t in Task, where: t.user_id == ^user_id)
  end

  def list_tasks_paginated(user_id, params \\ %{}) do
    page = params |> Map.get("page", "1") |> String.to_integer()
    per_page = params |> Map.get("per_page", "10") |> String.to_integer()
    order_by = params |> Map.get("order_by", "desc") |> String.to_atom()

    query = from t in Task,
            where: t.user_id == ^user_id

    query = case order_by do
      :asc -> from t in query, order_by: [asc: t.id]
      :desc -> from t in query, order_by: [desc: t.id]
      _ -> query
    end

    tasks = Repo.all(
      from t in query,
      limit: ^per_page,
      offset: ^((page - 1) * per_page)
    )

    total_entries = Repo.aggregate(query, :count, :id)

    {:ok, %{
      tasks: tasks,
      total_pages: ceil(total_entries / per_page),
      total_entries: total_entries,
      page_number: page,
      page_size: per_page,
      order_by: order_by
    }}
  end

  def get_task(id, user_id) do
    case Repo.get_by(Task, id: id, user_id: user_id) do
      nil -> {:error, :not_found}
      task -> {:ok, task}
    end
  end

  def create_task(user_id, attrs) do
    %Task{}
    |> Task.changeset(Map.put(attrs, "user_id", user_id))
    |> Repo.insert()
  end

  def update_task(task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  def delete_task(task), do: Repo.delete(task)

end
