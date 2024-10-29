defmodule TimeManager.TimeTracking.Application.ClockService do
  use TimeManager, :application_service

  alias __MODULE__

  alias TimeManager.TimeTracking.{
    ClockModel,
    Application.ClockRepository,
    Application.DateProvider
  }

  def clock_in_out(user_id) do
    last_clock = ClockRepository.get_last_by_id(user_id)

    case last_clock do
      nil ->
        insert_clock(user_id, "clock_in")

      last_clock ->
        case last_clock.status do
          :clock_in ->
            insert_clock(user_id, "clock_out")

          :clock_out ->
            insert_clock(user_id, "clock_in")
        end
    end
  end

  defp insert_clock(user_id, status) do
    %ClockModel{}
    |> ClockModel.changeset(%{status: status, user_id: user_id, time: DateProvider.now()})
    |> ClockRepository.insert()
  end

  def get_clocks() do
    ClockRepository.get_all()
  end

  def get_clocks_by_user(user_id) do
    ClockRepository.get_all_by_user(user_id)
  end

  def get_clocks_by_user(user_id, start_time, end_time) do
    ClockRepository.get_range_by_user(user_id, start_time, end_time)
  end

  def calculate_clock_stats(clocks) do
    total_time =
      clocks
      |> Enum.chunk_every(2)
      |> Enum.reduce(0, fn
        [%{status: :clock_in, time: start_time}, %{status: :clock_out, time: end_time}], acc ->
          acc + DateTime.diff(end_time, start_time, :minute)

        _, acc ->
          acc
      end)

    %{total_time: total_time}
  end

  def get_clocks_this_week(clocks) do
    # ClockRepository.get_all_by_user(user_id)
    now = DateProvider.now()
    beginning_of_week = Date.beginning_of_week(now)
    end_of_week = Date.end_of_week(now)

    clocks
    |> Enum.filter(fn clock ->
      Date.compare(clock.time, beginning_of_week) != :lt and
        Date.compare(clock.time, end_of_week) != :gt
    end)
  end

  def get_clocks_last_week(clocks) do
    now = DateProvider.now()
    beginning_of_week = Date.beginning_of_week(now)

    last_sunday = Date.add(beginning_of_week, -1)

    beginning_of_week = Date.beginning_of_week(last_sunday)
    last_week = Date.end_of_week(last_sunday)

    clocks
    |> Enum.filter(fn clock ->
      Date.compare(clock.time, beginning_of_week) != :lt and
        Date.compare(clock.time, last_week) != :gt
    end)
  end

  def calculate_percentage(%{total_time: total_time_first}, %{total_time: total_time_last}) do
    total_time_first = (total_time_first / 1) |> Float.round(2)
    total_time_last = (total_time_last / 1) |> Float.round(2)

    if total_time_first == 0 do
      0
    else
      percentage = (total_time_first - total_time_last) / total_time_first * 100
      percentage |> Float.round(2)
    end
  end

  def get_weekly_hour_stat_by_user(user_id) do
    clocks = ClockService.get_clocks_by_user(user_id)

    last_stats_week =
      ClockService.get_clocks_last_week(clocks)
      |> ClockService.calculate_clock_stats()

    this_week_stats =
      ClockService.get_clocks_this_week(clocks)
      |> ClockService.calculate_clock_stats()

    percentage = ClockService.calculate_percentage(this_week_stats, last_stats_week)

    %{this_week_stats: this_week_stats, last_stats_week: last_stats_week, percentage: percentage}
  end

  def get_daily_stats_by_range(user_id, start_time, end_time) do
    unprocessed_stats =
      ClockRepository.get_range_by_user_grouped_by_day(user_id, start_time, end_time)

    processed_stats =
      Enum.map(unprocessed_stats, fn day ->
        {the_day, the_clocks} = day

        the_day =
          the_day |> NaiveDateTime.to_date() |> Date.to_string() |> String.replace("-", "_")

        the_clocks = ClockService.calculate_clock_stats(the_clocks)

        {the_day, the_clocks.total_time}
      end)

    processed_stats
  end
end
