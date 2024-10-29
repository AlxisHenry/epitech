defmodule TimeManager.TimeTracking.Teams.Authorization do
  alias TimeManager.TimeTracking.Application.TeamService
  alias TimeManager.Accounts.Application.ManageUserService

  @behaviour Bodyguard.Policy
  # def authorize(_, %Accounts.UserModel{id: user_id}, _), do: :ok

  def authorize(
        :create_team,
        %{role: :manager, id: manager_id} = _user,
        %{"manager_id" => manager_id} = _team
      ),
      do: :ok

  def authorize(:get_teams, %{role: :admin}, _), do: :ok
  def authorize(:get_teams, %{role: :manager}, _), do: :ok

  def authorize(:get_team, %{role: :manager, id: manager_id}, %{"team_id" => team_id}) do
    case TeamService.get_team_by_id(team_id) do
      {:ok, team} when team.manager_id == manager_id -> :ok
      _ -> false
    end
  end

  # def authorize(:add_user_to_team, _, _), do: :ok

  def authorize(:add_user_to_team, %{role: :manager, id: manager_id}, %{
        "team_id" => team_id,
        "user_id" => user_id
      }) do
    is_my_team = is_my_team?(team_id, manager_id)
    is_my_user = is_my_user?(user_id, manager_id)

    with {:ok, :ok} <- {is_my_team, is_my_user} do
      :ok
    else
      _ -> false
    end
  end

  def authorize(:delete_team, %{role: :manager, id: manager_id}, %{"team_id" => team_id}) do
    is_my_team?(team_id, manager_id)
  end

  def authorize(:delete_user_from_team, %{role: :manager, id: manager_id}, %{
        "team_id" => team_id,
        "user_id" => user_id
      }) do
    is_my_team = is_my_team?(team_id, manager_id)
    is_my_user = is_my_user?(user_id, manager_id)

    with {:ok, :ok} <- {is_my_team, is_my_user} do
      :ok
    else
      _ -> false
    end
  end

  def authorize(:get_team_stat, %{role: :manager, id: manager_id}, %{"team_id" => team_id}) do
    is_my_team?(team_id, manager_id)
  end

  def authorize(:get_teams_of_user, %{role: :user, id: user_id}, %{"user_id" => user_id}), do: :ok

  def authorize(:get_teams_of_user, %{role: :manager, id: manager_id}, %{"user_id" => user_id}) do
    is_my_user?(user_id, manager_id)
  end

  def authorize(:get_teams_of_user, %{role: :admin}, _), do: :ok

  def authorize(_, %{role: :admin}, _), do: :ok
  def authorize(_, _, _), do: false

  defp is_my_team?(team_id, manager_id) do
    case TeamService.get_team_by_id(team_id) do
      {:ok, team} when team.manager_id == manager_id -> :ok
      _ -> false
    end
  end

  defp is_my_user?(user_id, manager_id) do
    case ManageUserService.get_user_by_id(user_id) do
      {:ok, user} when user.manager_id == manager_id -> :ok
      _ -> false
    end
  end
end

defmodule TimeManager.Teams do
  defdelegate authorize(action, user, params), to: TimeManager.TimeTracking.Teams.Authorization
end
