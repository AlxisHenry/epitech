defmodule TimeManager.TimeTracking.Application.WorkingTimeRepository do
  @self __MODULE__

  defp adapter() do
    Application.get_env(:time_manager, @self)
  end

  @callback insert(working_time :: WorkingTimeModel.t()) ::
              {:ok, WorkingTimeModel.t()} | {:error, any()}

  @callback get_all() :: [WorkingTimeModel.t()]
  @callback get_by_user(user_id :: integer()) :: [WorkingTimeModel.t()]
  @callback get_by_user(user_id :: integer(), start :: DateTime.t(), end_time :: DateTime.t()) ::
              [WorkingTimeModel.t()]
  @callback update_by_id(wt_id :: integer(), working_time :: WorkingTimeModel.t()) ::
              {:ok, WorkingTimeModel.t()} | {:error, any()}

  @callback delete_by_id(wt_id :: integer()) :: {:ok, WorkingTimeModel.t()} | {:error, any()}
  @callback get_range_by_user_grouped_by_day(
              user_id :: integer(),
              start :: DateTime.t(),
              end_time :: DateTime.t()
            ) ::
              {:ok, [WorkingTimeModel.t()]} | {:error, any()}

  def insert(working_time), do: adapter().insert(working_time)
  def get_all(), do: adapter().get_all()
  def get_by_user(user_id), do: adapter().get_by_user(user_id)
  def get_by_user(user_id, start, end_time), do: adapter().get_by_user(user_id, start, end_time)
  def update_by_id(wt_id, working_time), do: adapter().update_by_id(wt_id, working_time)
  def delete_by_id(wt_id), do: adapter().delete_by_id(wt_id)

  def get_range_by_user_grouped_by_day(user_id, start, end_time),
    do: adapter().get_range_by_user_grouped_by_day(user_id, start, end_time)
end
