defmodule TimeManager.Test.ClocksFixture do
  @one_hour 3600

  alias TimeManager.TimeTracking.Application.ClockService

  use TimeManagerWeb.ConnCase

  def when_user_clock_in(conn, user_id) do
    conn
    |> post("/api/clocks", %{"user_id" => user_id})
  end

  def then_clock_is_created(conn, _user) do
    _repsonse_body = Poison.decode!(conn.resp_body)

    assert conn.status == 200
  end

  def reset_fake_time() do
    Application.put_env(:time_manager, :fake_date_provider, 0)
  end

  def after_x_seconds(seconds) do
    time_to_put = Application.get_env(:time_manager, :fake_date_provider) + seconds
    Application.put_env(:time_manager, :fake_date_provider, time_to_put)
  end

  def get_fake_time() do
    Application.get_env(:time_manager, :fake_date_provider)
  end

  def when_user_get_all_clocks(conn) do
    get(conn, "/api/clocks")
  end

  def then_clocks_are_shown(conn) do
    _response_body = Poison.decode!(conn.resp_body)
    # IO.inspect(response_body)

    assert conn.status == 200
  end

  def when_user_get_all_clocks_by_user(conn, user_id) do
    get(conn, "/api/clocks/#{user_id}")
  end

  def simulate_clock_in_out_last_by_weeks(
        user_id,
        %{
          days: days,
          hours: hours,
          week: week
        }
      ) do
    for j <- 1..days do
      reset_fake_time()
      after_x_seconds(@one_hour * 24 * 7 * week)
      after_x_seconds(@one_hour * (24 * (j - 1)))
      ClockService.clock_in_out(user_id)
      after_x_seconds(@one_hour * hours)
      ClockService.clock_in_out(user_id)
    end

    reset_fake_time()
  end

  def when_user_get_week_stats(conn, user_id) do
    get(conn, "/api/clocks/week_stats/#{user_id}")
  end

  def then_week_stats_are_shown(conn) do
    response_body = Poison.decode!(conn.resp_body)

    assert conn.status == 200
  end
end
