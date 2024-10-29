defmodule TimeManagerWeb.ClockTest do
  @one_hour 3600

  use TimeManagerWeb.ConnCase, async: true
  alias TimeManager.Test.SetupFixture.{Registration, Auth, Authorization}
  import TimeManagerWeb.Test.UserBuilder
  import TimeManager.Test.ClocksFixture
  alias TimeManager.TimeTracking.Application.ClockService

  alias TimeManager.TimeTracking.Infrastructure.ClockRepository, as: TestRepo

  @moduletag :integration
  @moduletag :clocks

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

    reset_fake_time()
    [manager_id: manager_id, manager_token: manager_token, users: registred_users]
  end

  describe "As a User, " do
    test "I can clock in", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)

      user_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn
      |> Auth.put_auth_token(user_token)
      |> when_user_clock_in(user6.id)
      |> then_clock_is_created(user6)
    end

    test "I can clock out", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)

      user_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn
      |> Auth.put_auth_token(user_token)
      |> when_user_clock_in(user6.id)
      |> then_clock_is_created(user6)

      after_x_seconds(@one_hour * 8)

      conn
      |> Auth.put_auth_token(user_token)
      |> when_user_clock_in(user6.id)
      |> then_clock_is_created(user6)
    end

    test "I can't clock in/out for another user", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)
      user5 = hd(tl(users))

      user6_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user6_token)

      conn
      |> when_user_clock_in(user5.id)
      |> Authorization.assert_action_is_forbiden()
    end

    test "I can't get all clocks", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)

      user_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user_token)

      for _ <- 1..5 do
        conn
        |> when_user_clock_in(user6.id)
        |> then_clock_is_created(user6)

        after_x_seconds(@one_hour * 8 + round(@one_hour / 3))
      end

      conn
      |> Auth.put_auth_token(user_token)
      |> when_user_get_all_clocks()
      |> Authorization.assert_action_is_forbiden()
    end

    test "I can see my clocks", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)
      user5 = hd(tl(users))

      user6_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user6_token)

      for _ <- 1..2 do
        conn
        |> when_user_clock_in(user6.id)
        |> then_clock_is_created(user6)

        after_x_seconds(@one_hour)
      end

      user5_token =
        Auth.login_pass(user(5)["email"], user(5)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user5_token)

      for _ <- 1..10 do
        conn
        |> when_user_clock_in(user5.id)
        |> then_clock_is_created(user5)

        after_x_seconds(@one_hour)
      end

      conn
      |> Auth.put_auth_token(user6_token)
      |> when_user_get_all_clocks_by_user(user6.id)
      |> then_clocks_are_shown()
    end

    test "I can't see clocks of another user", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)
      user5 = hd(tl(users))

      user6_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user6_token)

      for _ <- 1..2 do
        conn
        |> when_user_clock_in(user6.id)
        |> then_clock_is_created(user6)

        after_x_seconds(@one_hour)
      end

      user5_token =
        Auth.login_pass(user(5)["email"], user(5)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user5_token)

      for _ <- 1..10 do
        conn
        |> when_user_clock_in(user5.id)
        |> then_clock_is_created(user5)

        after_x_seconds(@one_hour)
      end

      conn
      |> Auth.put_auth_token(user6_token)
      |> when_user_get_all_clocks_by_user(user5.id)
      |> Authorization.assert_action_is_forbiden()
    end

    test "I can get my stats of the week", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)

      user6_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user6_token)

      simulate_clock_in_out_last_by_weeks(user6.id, %{days: 5, hours: 1, week: -1})
      simulate_clock_in_out_last_by_weeks(user6.id, %{days: 5, hours: 3, week: 0})

      conn
      |> when_user_get_week_stats(user6.id)
      |> then_week_stats_are_shown()
    end

    test "I can't get stats of other users", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)
      user5 = hd(tl(users))

      user6_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user6_token)

      simulate_clock_in_out_last_by_weeks(user6.id, %{days: 5, hours: 1, week: -1})
      simulate_clock_in_out_last_by_weeks(user6.id, %{days: 5, hours: 3, week: 0})

      user5_token =
        Auth.login_pass(user(5)["email"], user(5)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user5_token)

      simulate_clock_in_out_last_by_weeks(user5.id, %{days: 5, hours: 1, week: -1})
      simulate_clock_in_out_last_by_weeks(user5.id, %{days: 5, hours: 3, week: 0})

      conn
      |> when_user_get_week_stats(user6.id)
      |> Authorization.assert_action_is_forbiden()
    end

    @tag :this
    test "I can get range by user grouped by day", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)

      user6_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user6_token)

      simulate_clock_in_out_last_by_weeks(user6.id, %{days: 5, hours: 6, week: -16})
      simulate_clock_in_out_last_by_weeks(user6.id, %{days: 5, hours: 7, week: -3})
      simulate_clock_in_out_last_by_weeks(user6.id, %{days: 5, hours: 7, week: -2})
      simulate_clock_in_out_last_by_weeks(user6.id, %{days: 5, hours: 7, week: -1})

      conn =
        conn
        |> get("/api/clocks/stats/daily/#{user6.id}?start_time=2024-01-01&end_time=2024-12-30")

      resp_body = Poison.decode!(conn.resp_body)

      assert conn.status == 200
    end

    test "I can't get range by user grouped by day for another user", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)
      user5 = hd(tl(users))

      user6_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user6_token)

      simulate_clock_in_out_last_by_weeks(user6.id, %{days: 5, hours: 6, week: -16})
      simulate_clock_in_out_last_by_weeks(user6.id, %{days: 5, hours: 7, week: -3})
      simulate_clock_in_out_last_by_weeks(user6.id, %{days: 5, hours: 7, week: -2})
      simulate_clock_in_out_last_by_weeks(user6.id, %{days: 5, hours: 7, week: -1})

      user5_token =
        Auth.login_pass(user(5)["email"], user(5)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user5_token)

      simulate_clock_in_out_last_by_weeks(user5.id, %{days: 5, hours: 6, week: -16})
      simulate_clock_in_out_last_by_weeks(user5.id, %{days: 5, hours: 7, week: -3})
      simulate_clock_in_out_last_by_weeks(user5.id, %{days: 5, hours: 7, week: -2})
      simulate_clock_in_out_last_by_weeks(user5.id, %{days: 5, hours: 7, week: -1})

      conn =
        conn
        |> get("/api/clocks/stats/daily/#{user6.id}?start_time=2024-01-01&end_time=2024-12-30")

      Authorization.assert_action_is_forbiden(conn)
    end
  end
end
