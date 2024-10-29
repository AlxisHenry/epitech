defmodule TimeManager.TimeTracking.Application.TeamService do
  use TimeManager, :application_service

  alias TimeManager.TimeTracking.{TeamModel, Application.TeamRepository, Application.ClockService}

  @self __MODULE__

  def get_teams() do
    case TeamRepository.get_all() do
      [] -> {:error, "Teams not found"}
      teams -> {:ok, teams}
    end
  end

  def get_teams(manager_id) do
    case TeamRepository.get_all(manager_id) do
      [] -> {:error, "Teams not found"}
      teams -> {:ok, teams}
    end
  end

  def get_team_by_id(id) do
    case TeamRepository.get_by_id(id) do
      nil -> {:error, "Team not found"}
      team -> {:ok, team}
    end
  end

  def get_team_by_manager(manager) do
    case TeamRepository.get_by_manager(manager) do
      nil -> {:error, "Team not found"}
      team -> {:ok, team}
    end
  end

  def get_team_by_user(user) do
    case TeamRepository.get_by_user(user) do
      nil -> {:error, "Team not found"}
      team -> {:ok, team}
    end
  end

  def create_team(params) do
    %TeamModel{}
    |> TeamModel.changeset(params)
    |> TeamRepository.insert()
  end

  def add_user_to_team(team, user) do
    team
    |> TeamRepository.add_user(user)
  end

  def update_team(team, update_team) do
    team
    |> TeamModel.changeset(update_team)
    |> TeamRepository.update(update_team)
  end

  def delete_team(team) do
    team
    |> TeamRepository.delete()
  end

  def delete_user_from_team(team_id, user_id) do
    team = TeamRepository.get_by_id(team_id)

    team
    |> TeamRepository.delete_user(user_id)
  end

  def get_average_hours_by_range(team_id, start_time, end_time) do
    {:ok, team} = @self.get_team_by_id(team_id)

    users = team.users

    number_of_users = Enum.count(users)

    users_clocks =
      Enum.map(users, fn user ->
        ClockService.get_clocks_by_user(user.id, start_time, end_time)
      end)

    total_time_team =
      Enum.reduce(users_clocks, 0, fn clocks, acc ->
        total_time = ClockService.calculate_clock_stats(clocks).total_time

        acc + total_time
      end)

    average = total_time_team / number_of_users

    average
  end

  def get_teams_of_user(user_id) do
    case TeamRepository.get_by_user(user_id) do
      [] -> {:error, "Teams not found"}
      teams -> {:ok, teams}
    end
  end

  def is_my_team?(team_id, manager_id) do
    case @self.get_team_by_id(team_id) do
      {:ok, team} when team.manager_id == manager_id -> :ok
      _ -> false
    end
  end
end
