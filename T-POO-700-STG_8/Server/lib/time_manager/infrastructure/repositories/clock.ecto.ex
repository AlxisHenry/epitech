defmodule TimeManager.TimeTracking.Infrastructure.ClockRepository do
  use TimeManager, :repository

  alias TimeManager.TimeTracking.{Application.ClockRepository, ClockModel}
  alias TimeManager.DateUtils

  @behaviour ClockRepository

  @impl ClockRepository
  def get_last_by_id(user_id) do
    with user_id <- user_id do
      query =
        from c in ClockModel,
          where: c.user_id == ^user_id,
          order_by: [desc: c.time],
          limit: 1

      query
      |> Repo.one()
    else
      {:error, _} -> {:error, "is not a valid UUID"}
    end
  end

  @impl ClockRepository
  def insert(clock) do
    Repo.insert!(clock)
  end

  @impl ClockRepository
  def get_all() do
    Repo.all(ClockModel)
  end

  @impl ClockRepository
  def get_all_by_user(user_id) do
    with user_id <- user_id do
      query =
        from c in ClockModel,
          where: c.user_id == ^user_id,
          order_by: [asc: c.time]

      query
      |> Repo.all()
    else
      {:error, _} -> {:error, "is not a valid UUID"}
    end
  end

  @impl true
  def get_range_by_user(
        user_id,
        start_time,
        end_time
      ) do
    start_time = DateUtils.convert_to_utc_datetime(start_time)
    end_time = DateUtils.convert_to_utc_datetime(end_time, :end)

    with user_id <- user_id do
      query =
        from c in ClockModel,
          where: c.user_id == ^user_id and c.time >= ^start_time and c.time <= ^end_time,
          order_by: [asc: c.time]

      query
      |> Repo.all()
    else
      {:error, _} -> {:error, "is not a valid UUID"}
    end
  end

  @impl true
  def get_range_by_user_grouped_by_day(
        user_id,
        start_time,
        end_time
      ) do
    start_time = DateUtils.convert_to_utc_datetime(start_time)
    end_time = DateUtils.convert_to_utc_datetime(end_time, :end)

    with user_id <- user_id do
      query =
        from c in ClockModel,
          where: c.user_id == ^user_id and c.time >= ^start_time and c.time <= ^end_time,
          select: %{
            day: fragment("date_trunc('day', ?)", c.time),
            clock_id: c.id,
            time: c.time,
            status: c.status
          },
          order_by: [asc: fragment("date_trunc('day', ?)", c.time), asc: c.time]

      query
      |> Repo.all()
      |> Enum.group_by(fn %{day: day} -> day end)
    else
      {:error, _} -> {:error, "is not a valid UUID"}
    end
  end
end
