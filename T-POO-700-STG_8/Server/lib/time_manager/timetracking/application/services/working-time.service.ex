defmodule TimeManager.TimeTracking.Application.WorkingTimeService do
  use TimeManager, :application_service

  alias TimeManager.TimeTracking.{Application.WorkingTimeRepository, WorkingTimeModel}

  def create_wt(params) do
    %WorkingTimeModel{}
    |> WorkingTimeModel.changeset(params)
    |> WorkingTimeRepository.insert()
  end

  def get_wts() do
    case WorkingTimeRepository.get_all() do
      working_times -> {:ok, working_times}
    end
  end

  def get_wts_by_user(user_id) do
    case WorkingTimeRepository.get_by_user(user_id) do
      working_times -> {:ok, working_times}
    end
  end

  def get_wts_by_user(user_id, start, end_time) do
    case WorkingTimeRepository.get_by_user(user_id, start, end_time) do
      working_times -> {:ok, working_times}
    end
  end

  def update_by_user(user_id, working_time) do
    case WorkingTimeRepository.update_by_id(user_id, working_time) do
      {:ok, working_time} -> {:ok, working_time}
      {:error, _} -> {:error, "Error updating working time"}
    end
  end

  def delete_wt(wt_id) do
    case WorkingTimeRepository.delete_by_id(wt_id) do
      {:ok, working_time} -> {:ok, working_time}
      {:error, _} -> {:error, "Error deleting working time"}
    end
  end

  def calculate_wts_time(working_times) do
    Enum.reduce(working_times, 0, fn wt, acc ->
      duration = DateTime.diff(wt.end_time, wt.start_time, :minute)
      acc + duration
    end)
  end

  def get_wt_by_user_by_range(user_id, start_time, end_time) do
    unprocessed_stats =
      WorkingTimeRepository.get_range_by_user_grouped_by_day(user_id, start_time, end_time)

    processed_stats =
      Enum.map(unprocessed_stats, fn day ->
        {the_day, stats} = day

        the_day =
          the_day |> NaiveDateTime.to_date() |> Date.to_string() |> String.replace(~r/-/, "_")

        total_time = calculate_wts_time(stats)

        {the_day, total_time}
      end)
  end
end
