defmodule TimeManager.TimeTracking.Clocks.ClockAuthorization do
  alias TimeManager.Accounts.Application.ManageUserService

  @behaviour Bodyguard.Policy

  def authorize(:clock_in_out, %{role: :user, id: user_id}, %{"user_id" => user_id}), do: :ok
  def authorize(:clock_in_out, %{role: :admin}, _), do: :ok

  def authorize(:get_clocks, %{role: :admin}, _), do: :ok

  def authorize(:get_my_clocks, %{role: :user, id: user_id}, %{"user_id" => user_id}), do: :ok
  def authorize(:get_my_clocks, %{role: :admin}, _), do: :ok

  def authorize(:get_my_clocks, %{role: :manager, id: manager_id}, %{"user_id" => user_id}) do
    ManageUserService.is_my_user?(user_id, manager_id)
  end

  def authorize(:get_week_stats, %{role: :user, id: user_id}, %{"user_id" => user_id}), do: :ok
  def authorize(:get_week_stats, %{role: :admin}, _), do: :ok

  def authorize(:get_week_stats, %{role: :manager, id: manager_id}, %{"user_id" => user_id}) do
    ManageUserService.is_my_user?(user_id, manager_id)
  end

  def authorize(:get_daily_stats, %{role: :user, id: user_id}, %{"user_id" => user_id}), do: :ok
  def authorize(:get_daily_stats, %{role: :admin}, _), do: :ok

  def authorize(:get_daily_stats, %{role: :manager, id: manager_id}, %{"user_id" => user_id}) do
    ManageUserService.is_my_user?(user_id, manager_id)
  end

  def authorize(_, _, _), do: false
end

defmodule TimeManager.Clocks do
  defdelegate authorize(action, user, params),
    to: TimeManager.TimeTracking.Clocks.ClockAuthorization
end
