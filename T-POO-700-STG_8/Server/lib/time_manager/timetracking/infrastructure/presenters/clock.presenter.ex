defmodule TimeManager.TimeTracking.Infrastructure.ClockPresenter do
  @self __MODULE__
  use TimeManagerWeb, :view

  alias TimeManager.TimeTracking.ClockModel

  defp minute_to_hour(minutes) do
    hours = div(trunc(minutes), 60)
    minutes = rem(trunc(minutes), 60)

    "#{hours}h #{minutes}m"
  end

  def present_clock(%{clock: %ClockModel{} = clock}) do
    %{
      id: clock.id,
      status: clock.status,
      user_id: clock.user_id,
      time: clock.time
    }
  end

  def present_clocks(%{clocks: clocks}) do
    %{data: for(clock <- clocks, do: present_clock(%{clock: clock}))}
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

  def present_stats(%{stats: stats}) do
    last_stats_week = minute_to_hour(stats[:last_stats_week][:total_time])
    this_week_stats = minute_to_hour(stats[:this_week_stats][:total_time])

    %{
      last_stats_week: last_stats_week,
      percentage: stats[:percentage],
      this_week_stats: this_week_stats
    }
  end

  def render_result(conn, result, status \\ :ok)

  def render_result(conn, result, status) when is_list(result) do
    conn
    |> put_status(status)
    |> put_view(@self)
    |> render(:present_clocks, clocks: result)
  end

  def render_result(conn, result, status) do
    conn
    |> put_status(status)
    |> put_view(@self)
    |> render(:present_clock, clock: result)
  end

  def render_stats(conn, result, status \\ :ok) do
    conn
    |> put_status(status)
    |> put_view(@self)
    |> render(:present_stats, stats: result)
  end

  def render_daily_stat(conn, result) do
    conn
    |> put_status(:ok)
    |> put_view(@self)
    |> render(:present_stats, stats: result)
  end

  def render_error(conn, template, status) do
    conn
    |> put_status(status)
    |> put_view(TimeManagerWeb.ErrorView)
    |> render(template)
  end
end
