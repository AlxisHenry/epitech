defmodule TimeManager.Test.TeamsFixture do
  use TimeManagerWeb.ConnCase
  alias TimeManager.TimeTracking.Application.TeamService

  def when_manager_creates_team(conn, team) do
    post(conn, "/api/teams", %{team: team})
  end

  def then_team_was_created(conn, team) do
    response_body = json_response(conn, 201)

    assert response_body["name"] == team["name"]
    assert response_body["manager"]["id"] == team["manager_id"]
  end

  def when_manager_adds_user_to_team(conn, team_id, user_id) do
    post(conn, "/api/teams/#{team_id}/users", %{user_id: user_id})
  end

  def when_user_gets_team(conn, team_id) do
    get(conn, "/api/teams/#{team_id}")
  end

  def when_user_gets_teams(conn) do
    get(conn, "/api/teams")
  end

  def when_user_delete_team(conn, team_id) do
    delete(conn, "/api/teams/#{team_id}")
  end

  def when_manager_removes_user_from_team(conn, team_id, user_id) do
    delete(conn, "/api/teams/#{team_id}/users/#{user_id}")
  end

  def then_user_was_removed_from_team(conn, team, removed_user) do
    response_body = json_response(conn, 200)

    assert response_body["name"] == team.name
    assert response_body["manager"]["id"] == team.manager.id

    users = response_body["users"]["data"]

    assert Enum.all?(users, fn user ->
             user["id"] != removed_user.id
           end)
  end

  def then_team_was_deleted(conn) do
    assert conn.status == 204
  end

  def then_team_was_returned(conn, team) do
    response_body = json_response(conn, 200)

    assert response_body["name"] == team.name
    assert response_body["manager"]["id"] == team.manager.id
  end

  def then_teams_were_returned(conn, teams) do
    response_body = json_response(conn, 200)

    assert Enum.all?(teams, fn team ->
             Enum.any?(response_body["data"], fn response_team ->
               response_team["name"] == team.name
             end)
           end)
  end

  def given_team_exists(team) do
    team
    |> TeamService.create_team()
  end

  def then_user_was_added_to_team(conn, team, added_users) do
    response_body = json_response(conn, 201)

    assert response_body["name"] == team.name

    assert response_body["manager"]["id"] == team.manager.id

    assert Enum.all?(added_users, fn user ->
             Enum.any?(response_body["users"]["data"], fn response_user ->
               response_user["id"] == user.id
             end)
           end)
  end

  def then_conflict_response(conn) do
    assert conn.status == 409
  end

  def then_not_found_response(conn) do
    assert conn.status == 404
  end
end
