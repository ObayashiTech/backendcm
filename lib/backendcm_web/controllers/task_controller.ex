defmodule BackendcmWeb.TaskController do
  use BackendcmWeb, :controller

  alias Backendcm.Tasks

  # Proteção por Plug (caso não esteja no router)
  plug BackendcmWeb.Plugs.Auth

  action_fallback BackendcmWeb.FallbackController

  def index(conn, params) do
    case Tasks.list_tasks_paginated(conn.assigns.current_user_id, params) do
      {:ok, result} ->
        render(conn, :index, result)

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: reason})
    end
  end

  def create(conn, task_params) do
    user_id = conn.assigns.current_user_id

    case Tasks.create_task(user_id, task_params) do
      {:ok, task} ->
        conn
        |> put_status(:created)
        |> render(:show, task: task)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id} = task_params) do
    user_id = conn.assigns.current_user_id

    with {:ok, task} <- Tasks.get_task(id, user_id),
         {:ok, task} <- Tasks.update_task(task, task_params) do
      render(conn, :show, task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user_id

    with {:ok, task} <- Tasks.get_task(id, user_id),
         {:ok, _task} <- Tasks.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
