defmodule TimeManager.TimeTracking.Infrastructure.WorkingTimeRepository do
  use TimeManager, :repository

  alias TimeManager.TimeTracking.Application.WorkingTimeRepository
  alias TimeManager.TimeTracking.WorkingTimeModel
  alias TimeManager.DateUtils

  @behaviour WorkingTimeRepository

  @impl true
  def insert(working_time) do
    working_time
    |> Repo.insert()
  end

  @impl true
  def get_all() do
    Repo.all(WorkingTimeModel)
  end

  @impl true
  def get_by_user(user_id) do
    from(w in WorkingTimeModel, where: w.user_id == ^user_id)
    |> Repo.all()
  end

  @impl true
  def get_by_user(user_id, start, end_time) do
    {:ok, start_date} = Date.from_iso8601(start)
    {:ok, start_naive} = NaiveDateTime.new(start_date, ~T[00:00:00])
    {:ok, start_datetime} = DateTime.from_naive(start_naive, "Etc/UTC")

    {:ok, end_date} = Date.from_iso8601(end_time)
    {:ok, end_naive} = NaiveDateTime.new(end_date, ~T[23:59:59])
    {:ok, end_datetime} = DateTime.from_naive(end_naive, "Etc/UTC")

    from(w in WorkingTimeModel,
      where:
        w.user_id == ^user_id and w.start_time >= ^start_datetime and w.end_time <= ^end_datetime
    )
    |> Repo.all()
  end

  @impl true
  def update_by_id(wt_id, working_time) do
    wt = Repo.get(WorkingTimeModel, wt_id)

    case wt do
      nil ->
        {:error, "Working time not found"}

      wt ->
        wt
        |> WorkingTimeModel.changeset_update(working_time)
        |> Repo.update()
    end
  end

  @impl true
  def delete_by_id(wt_id) do
    wt = Repo.get(WorkingTimeModel, wt_id)

    case wt do
      nil ->
        {:error, "Working time not found"}

      wt ->
        Repo.delete(wt)
        {:ok, wt}
    end
  end

  @impl true
  def get_range_by_user_grouped_by_day(user_id, start, end_time) do
    start_time = DateUtils.convert_to_utc_datetime(start)
    end_time = DateUtils.convert_to_utc_datetime(end_time)

    query =
      from w in WorkingTimeModel,
        where: w.user_id == ^user_id and w.start_time >= ^start_time and w.end_time <= ^end_time,
        select: %{
          day: fragment("date_trunc('day', ?)", w.start_time),
          working_time_id: w.id,
          start_time: w.start_time,
          end_time: w.end_time
        },
        order_by: [asc: w.start_time]

    query
    |> Repo.all()
    |> Enum.group_by(fn %{day: day} -> day end)
  end
end
