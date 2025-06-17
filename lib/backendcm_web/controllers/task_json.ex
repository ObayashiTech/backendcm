defmodule BackendcmWeb.TaskJSON do
  alias Backendcm.Tasks.Task

  def index(%{tasks: tasks, total_pages: total_pages, total_entries: total_entries, page_number: page_number, page_size: page_size, order_by: order_by}) do
    %{
      tasks: Enum.map(tasks, &task_json/1),
      meta: %{
        order_by: order_by,
        current_page: page_number,
        total_pages: total_pages,
        total_entries: total_entries,
        per_page: page_size
      }
    }
  end

  def index(%{tasks: tasks}) do
    %{tasks: Enum.map(tasks, &task_json/1)}
  end

  def show(%{task: task}) do
    %{task: task_json(task)}
  end

  defp task_json(%Task{
         id: id,
         title: title,
         done: done,
       }) do
    %{
      id: id,
      title: title,
      done: done
    }
  end
end
