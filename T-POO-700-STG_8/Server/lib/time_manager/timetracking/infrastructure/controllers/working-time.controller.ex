defmodule TimeManagerWeb.TimeTracking.Infrastructure.WorkingTimeController do
  use TimeManagerWeb, :controller

  action_fallback TimeManagerWeb.FallbackController

  alias TimeManager.TimeTracking.{
    Infrastructure.WorkingTimePresenter,
    Application.WorkingTimeService
  }

  def create_working_time(conn, %{"working_time" => working_time_params}) do
    current_user = conn.assigns[:current_user]

    working_time_params = Map.put(working_time_params, "manager_id", current_user.id)

    case WorkingTimeService.create_wt(working_time_params) do
      {:ok, working_time} ->
        WorkingTimePresenter.render_result(conn, working_time, :created)

      {:error, _} ->
        WorkingTimePresenter.render_error(conn, "500.json", :internal_server_error)
    end
  end

  def get_working_times(conn, _assigns) do
    case WorkingTimeService.get_wts() do
      {:ok, working_times} ->
        WorkingTimePresenter.render_result(conn, working_times)

      {:error, _} ->
        WorkingTimePresenter.render_error(conn, "500.json", :internal_server_error)
    end
  end

  def get_working_times_by_user(conn, %{"user_id" => user_id, "start" => start, "end" => end_time}) do
    case WorkingTimeService.get_wts_by_user(user_id, start, end_time) do
      {:ok, working_times} ->
        WorkingTimePresenter.render_result(conn, working_times)

      {:error, _} ->
        WorkingTimePresenter.render_error(conn, "500.json", :internal_server_error)
    end
  end

  def get_working_times_by_user(conn, %{"user_id" => user_id}) do
    case WorkingTimeService.get_wts_by_user(user_id) do
      {:ok, working_times} ->
        WorkingTimePresenter.render_result(conn, working_times)

      {:error, _} ->
        WorkingTimePresenter.render_error(conn, "500.json", :internal_server_error)
    end
  end

  def update_working_time(conn, %{"id" => wt_id, "working_time" => wt}) do
    case WorkingTimeService.update_by_user(wt_id, wt) do
      {:ok, working_time} ->
        WorkingTimePresenter.render_result(conn, working_time)

      {:error, _} ->
        WorkingTimePresenter.render_error(conn, "500.json", :internal_server_error)
    end
  end

  def delete_working_time(conn, %{"id" => wt_id}) do
    case WorkingTimeService.delete_wt(wt_id) do
      {:ok, _} ->
        conn
        |> WorkingTimePresenter.render_result([], :no_content)

      {:error, _} ->
        WorkingTimePresenter.render_error(conn, "500.json", :internal_server_error)
    end
  end

  def get_working_times_by_user_by_range(conn, %{
        "user_id" => user_id,
        "start" => start,
        "end" => end_time
      }) do
    IO.inspect(user_id)

    case WorkingTimeService.get_wt_by_user_by_range(user_id, start, end_time) do
      {:error, _} ->
        WorkingTimePresenter.render_error(conn, "500.json", :internal_server_error)

      data ->
        WorkingTimePresenter.render_stats(conn, data, :ok)
    end
  end
end
