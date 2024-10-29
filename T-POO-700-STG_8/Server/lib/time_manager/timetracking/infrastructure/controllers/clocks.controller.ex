defmodule TimeManagerWeb.TimeTracking.Infrastructure.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.TimeTracking.{Application.ClockService, Infrastructure.ClockPresenter}

  alias TimeManager.Clocks

  def clock(conn, %{"user_id" => user_id}) do
    user_assigns = conn.assigns[:current_user]

    basic_authorizations =
      Bodyguard.permit(Clocks, :clock_in_out, user_assigns, %{"user_id" => user_id})

    with :ok <- basic_authorizations do
      case ClockService.clock_in_out(user_id) do
        {:error, _} ->
          ClockPresenter.render_error(conn, "500.json", :internal_server_error)

        clock ->
          ClockPresenter.render_result(conn, clock)
      end
    else
      {:error, _} ->
        ClockPresenter.render_error(conn, "403.json", :forbidden)
    end
  end

  def get_clocks(conn, _assigns) do
    user_assigns = conn.assigns[:current_user]

    basic_authorizations =
      Bodyguard.permit(Clocks, :get_clocks, user_assigns, %{})

    with :ok <- basic_authorizations do
      case ClockService.get_clocks() do
        {:error, _} ->
          ClockPresenter.render_error(conn, "500.json", :internal_server_error)

        clocks ->
          ClockPresenter.render_result(conn, clocks)
      end
    else
      {:error, _} ->
        ClockPresenter.render_error(conn, "403.json", :forbidden)
    end
  end

  def get_clocks_by_user(conn, %{"user_id" => user_id}) do
    user_assigns = conn.assigns[:current_user]

    basic_authorizations =
      Bodyguard.permit(Clocks, :get_my_clocks, user_assigns, %{"user_id" => user_id})

    with :ok <- basic_authorizations do
      case ClockService.get_clocks_by_user(user_id) do
        {:error, _} ->
          ClockPresenter.render_error(conn, "500.json", :internal_server_error)

        clocks ->
          ClockPresenter.render_result(conn, clocks)
      end
    else
      {:error, _} ->
        ClockPresenter.render_error(conn, "403.json", :forbidden)
    end
  end

  def get_week_stats(conn, %{"user_id" => user_id}) do
    user_assigns = conn.assigns[:current_user]

    basic_authorizations =
      Bodyguard.permit(Clocks, :get_week_stats, user_assigns, %{"user_id" => user_id})

    with :ok <- basic_authorizations do
      case ClockService.get_weekly_hour_stat_by_user(user_id) do
        {:error, _} ->
          ClockPresenter.render_error(conn, "500.json", :internal_server_error)

        stats ->
          ClockPresenter.render_stats(conn, stats)
      end
    else
      {:error, _} ->
        ClockPresenter.render_error(conn, "403.json", :forbidden)
    end
  end

  def get_daily_stats(conn, %{
        "user_id" => user_id,
        "start_time" => start_time,
        "end_time" => end_time
      }) do
    user_assigns = conn.assigns[:current_user]

    basic_authorizations =
      Bodyguard.permit(Clocks, :get_daily_stats, user_assigns, %{"user_id" => user_id})

    with :ok <- basic_authorizations do
      case ClockService.get_daily_stats_by_range(user_id, start_time, end_time) do
        {:error, _} ->
          ClockPresenter.render_error(conn, "500.json", :internal_server_error)

        stats ->
          ClockPresenter.render_stats(conn, stats)
      end
    else
      {:error, _} ->
        ClockPresenter.render_error(conn, "403.json", :forbidden)
    end
  end
end
