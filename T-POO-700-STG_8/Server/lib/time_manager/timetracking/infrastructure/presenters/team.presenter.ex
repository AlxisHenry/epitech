defmodule TimeManager.TimeTracking.Infrastructure.TeamPresenter do
  use TimeManagerWeb, :view

  alias TimeManager.TimeTracking.TeamModel
  alias TimeManager.Accounts.Infrastructure.UserPresenter

  def present_team(%{team: %TeamModel{} = team}) do
    %{
      id: team.id,
      name: team.name,
      manager_id: team.manager_id
    }
  end

  def present_teams(%{teams: teams}) do
    %{data: for(team <- teams, do: present_team(%{team: team}))}
  end

  def present_team_with_manager(%{team: %TeamModel{} = team}) do
    %{
      id: team.id,
      name: team.name,
      manager: UserPresenter.present_manager(team.manager),
      users: UserPresenter.present_users_without_manager(%{users: team.users})
    }
  end

  def present_team_with_manager(_team) do
    %{}
  end

  def present_teams_with_manager(%{teams: teams}) do
    %{data: for(team <- teams, do: present_team_with_manager(%{team: team}))}
  end

  def present_stat(%{average: average}) do
    hours = div(trunc(average), 60)
    minutes = rem(trunc(average), 60)

    average = "#{hours}h #{minutes}m"

    %{average: average}
  end

  def render_result(conn, result, status \\ :ok)

  def render_result(conn, result, status) when is_float(result) do
    conn
    |> put_status(status)
    |> put_view(TimeManager.TimeTracking.Infrastructure.TeamPresenter)
    |> render(:present_stat, average: result)
  end

  def render_result(conn, result, status) when is_list(result) do
    conn
    |> put_status(status)
    |> put_view(TimeManager.TimeTracking.Infrastructure.TeamPresenter)
    |> render(:present_teams_with_manager, teams: result)
  end

  def render_result(conn, result, status) do
    conn
    |> put_status(status)
    |> put_view(TimeManager.TimeTracking.Infrastructure.TeamPresenter)
    |> render(:present_team_with_manager, team: result)
  end

  def render_error(conn, template, status) do
    conn
    |> put_status(status)
    |> put_view(TimeManagerWeb.ErrorView)
    |> render(template)
  end
end
