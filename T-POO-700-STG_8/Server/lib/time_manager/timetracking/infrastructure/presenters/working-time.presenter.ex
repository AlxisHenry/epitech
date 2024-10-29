defmodule TimeManager.TimeTracking.Infrastructure.WorkingTimePresenter do
  @self __MODULE__
  use TimeManagerWeb, :view

  alias TimeManager.TimeTracking.WorkingTimeModel

  defp minute_to_hour(minutes) do
    hours = div(trunc(minutes), 60)
    minutes = rem(trunc(minutes), 60)

    "#{hours}h #{minutes}m"
  end

  def present_working_time(%{working_time: %WorkingTimeModel{} = working_time}) do
    %{
      id: working_time.id,
      start_time: working_time.start_time,
      end_time: working_time.end_time,
      break_duration: working_time.break_duration,
      user_id: working_time.user_id,
      manager_id: working_time.manager_id
    }
  end

  def present_working_times(%{working_times: working_times}) do
    %{
      data:
        for(
          working_time <- working_times,
          do: present_working_time(%{working_time: working_time})
        )
    }
  end

  def render_result(conn, result, status \\ :ok)

  def render_result(conn, result, status) when is_list(result) do
    conn
    |> put_status(status)
    |> put_view(@self)
    |> render(:present_working_times, working_times: result)
  end

  def present_stats(%{stats: stats}) when is_list(stats) do
    stats =
      Enum.map(stats, fn stat ->
        {key, minutes} = stat

        {key, minute_to_hour(minutes)}
      end)
      |> Enum.into(%{})

    %{
      data: stats
    }
  end

  def render_stats(conn, result, status) do
    conn
    |> put_status(status)
    |> put_view(@self)
    |> render(:present_stats, stats: result)
  end

  def render_result(conn, result, status) do
    conn
    |> put_status(status)
    |> put_view(@self)
    |> render(:present_working_time, working_time: result)
  end

  def render_error(conn, template, status) do
    conn
    |> put_status(status)
    |> put_view(TimeManagerWeb.ErrorView)
    |> render(template)
  end
end
