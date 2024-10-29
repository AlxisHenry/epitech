defmodule TimeManagerWeb.TeamsTest do
  use TimeManagerWeb.ConnCase, async: true
  alias TimeManager.Test.SetupFixture.{Registration, Auth, Authorization, Accounts}
  import TimeManagerWeb.Test.UserBuilder
  alias TimeManager.Test.TeamsFixture

  alias TimeManager.TimeTracking.Application.TeamService

  alias TimeManager.Test.ClocksFixture

  @moduletag :integration
  @moduletag :teams

  setup do
    manager1 = user(1, :manager)

    user1 = user(1)
    user2 = user(2)
    user3 = user(3)
    user4 = user(4)
    user5 = user(5)
    user6 = user(6)

    registred_users =
      Registration.given_existing_users([manager1, user1, user2, user3, user4, user5, user6])

    manager_id = List.last(registred_users).id

    manager_auth_response = Auth.login_pass(manager1["email"], manager1["password"])

    manager_token = Auth.extract_auth_token(manager_auth_response)

    [manager_id: manager_id, manager_token: manager_token, users: registred_users]
  end

  describe "As a Manager, " do
    test "I can create a blank team", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token
    } do
      team_params = %{
        "name" => "Team 1",
        "manager_id" => manager_id
      }

      conn
      |> Auth.put_auth_token(manager_token)
      |> TeamsFixture.when_manager_creates_team(team_params)
      |> TeamsFixture.then_team_was_created(team_params)
    end

    test "I can add a user assigned to me, to my team", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      user1 = List.first(users)

      user1
      |> Accounts.update_user(%{"manager_id" => manager_id})

      _team =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> TeamsFixture.then_user_was_added_to_team(team, [user1])
    end

    test "I can't add a user not assigned to me, to my team", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      user1 = List.first(users)

      _team =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> Authorization.assert_action_is_forbiden()
    end

    test "I can add multiple users to my team", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      user1 = hd(tl(users))
      user2 = hd(users)

      [user1, user2]
      |> Enum.map(fn user ->
        user
        |> Accounts.update_user(%{"manager_id" => manager_id})
      end)

      _team =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user2.id)
        |> TeamsFixture.then_user_was_added_to_team(team, [user1, user2])
    end

    test "I can't add a user to a team multiple times", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      user1 = hd(tl(users))

      user1
      |> Accounts.update_user(%{"manager_id" => manager_id})

      _team =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> TeamsFixture.then_conflict_response()
    end

    test "I can't get another team by id", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      user6 = hd(users)

      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => user6.id
        }
        |> TeamsFixture.given_team_exists()

      _team =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_user_gets_team(team.id)
        |> Authorization.assert_action_is_forbiden()
    end

    test "I can't get all teams", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token
    } do
      {:ok, team1} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      {:ok, team2} =
        %{
          "name" => "Team 2",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      conn
      |> Auth.put_auth_token(manager_token)
      |> TeamsFixture.when_user_gets_teams()
      |> TeamsFixture.then_teams_were_returned([team1, team2])
    end

    test "I can't get a team that doesn't exist", %{
      conn: conn,
      manager_token: manager_token
    } do
      conn
      |> Auth.put_auth_token(manager_token)
      |> TeamsFixture.when_user_gets_team(999)
      |> Authorization.assert_action_is_forbiden()
    end

    test "I can't delete a team not mine", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      user6 = hd(users)

      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => user6.id
        }
        |> TeamsFixture.given_team_exists()

      conn
      |> Auth.put_auth_token(manager_token)
      |> TeamsFixture.when_user_delete_team(team.id)
      |> Authorization.assert_action_is_forbiden()
    end

    test "I can delete a team", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token
    } do
      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      conn
      |> Auth.put_auth_token(manager_token)
      |> TeamsFixture.when_user_delete_team(team.id)
      |> TeamsFixture.then_team_was_deleted()
    end

    test "I can delete a team with users in it", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      user1 = hd(tl(users))
      user2 = hd(users)

      [user1, user2]
      |> Enum.map(fn user ->
        user
        |> Accounts.update_user(%{"manager_id" => manager_id})
      end)

      conn =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user2.id)

      team = conn.assigns.team

      conn
      |> TeamsFixture.when_user_delete_team(team.id)
      |> TeamsFixture.then_team_was_deleted()
    end

    test "I can remove a user from team", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      user1 = hd(tl(users))
      user2 = hd(users)

      [user1, user2]
      |> Enum.map(fn user ->
        user
        |> Accounts.update_user(%{"manager_id" => manager_id})
      end)

      conn =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user2.id)

      team = conn.assigns.team

      conn
      |> TeamsFixture.when_manager_removes_user_from_team(team.id, user1.id)
      |> TeamsFixture.then_user_was_removed_from_team(team, user1)
    end

    test "I can view average stats of a team by week", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      {:ok, team} =
        %{
          "name" => "team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      user1 = hd(tl(users))
      user2 = hd(users)

      [user1, user2]
      |> Enum.map(fn user ->
        user
        |> Accounts.update_user(%{"manager_id" => manager_id})
      end)

      conn
      |> Auth.put_auth_token(manager_token)
      |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
      |> TeamsFixture.when_manager_adds_user_to_team(team.id, user2.id)

      ClocksFixture.simulate_clock_in_out_last_by_weeks(user1.id, %{days: 1, hours: 1, week: -1})
      ClocksFixture.simulate_clock_in_out_last_by_weeks(user1.id, %{days: 1, hours: 1, week: 0})

      ClocksFixture.simulate_clock_in_out_last_by_weeks(user2.id, %{days: 7, hours: 8, week: 0})

      conn =
        conn
        |> Auth.put_auth_token(manager_token)
        |> get("/api/teams/stats/#{team.id}?start_time=2021-01-01&end_time=2025-01-31")

      response_body = Poison.decode!(conn.resp_body)

      # je sais que c'est 29
      assert response_body["average"] == "29h 0m"
    end

    test "I get all teams of user", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      user1 = hd(tl(users))
      user2 = hd(users)

      [user1, user2]
      |> Enum.map(fn user ->
        user
        |> Accounts.update_user(%{"manager_id" => manager_id})
      end)

      conn = conn |> Auth.put_auth_token(manager_token)

      team_params = %{
        "name" => "Team 1",
        "manager_id" => manager_id
      }

      team_params2 = %{
        "name" => "Team 2",
        "manager_id" => manager_id
      }

      res1 =
        conn
        |> TeamsFixture.when_manager_creates_team(team_params)

      res2 =
        conn
        |> TeamsFixture.when_manager_creates_team(team_params2)

      conn
      |> TeamsFixture.when_manager_adds_user_to_team(res1.assigns.team.id, user1.id)

      conn
      |> TeamsFixture.when_manager_adds_user_to_team(res2.assigns.team.id, user1.id)

      conn =
        conn
        |> get("/api/teams/user/#{user1.id}")

      response_body = Poison.decode!(conn.resp_body)

      assert Enum.count(response_body["data"]) == 2
      assert Enum.any?(response_body["data"], fn team -> team["name"] == "Team 1" end)
      assert Enum.any?(response_body["data"], fn team -> team["name"] == "Team 2" end)
    end
  end
end
