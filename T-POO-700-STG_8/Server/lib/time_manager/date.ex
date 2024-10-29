defmodule TimeManager.DateUtils do
  def convert_to_utc_datetime(date_string, time_of_day \\ :start) do
    {:ok, date} = Date.from_iso8601(date_string)

    time =
      case time_of_day do
        :start -> ~T[00:00:00]
        :end -> ~T[23:59:59]
      end

    {:ok, naive_datetime} = NaiveDateTime.new(date, time)

    {:ok, utc_datetime} = DateTime.from_naive(naive_datetime, "Etc/UTC")

    utc_datetime
  end
end
