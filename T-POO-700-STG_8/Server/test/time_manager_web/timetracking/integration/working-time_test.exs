defmodule TimeManagerWeb.WorkingTimeTest do
  use TimeManagerWeb.ConnCase, async: true
  alias TimeManager.Test.SetupFixture.{Registration, Auth}
  import TimeManagerWeb.Test.UserBuilder
  import TimeManager.Test.WorkingTimesFixture

  alias TimeManager.TimeTracking.Application.WorkingTimeService

  @moduletag :integration
  @moduletag :working_time

  setup do
    :ok

    bunch_of_users = Enum.map(1..10, fn i -> user(i) end)

    registred_users =
      Registration.given_existing_users(bunch_of_users)

    users = registred_users
    manager = List.last(users)

    working_time = %{
      "user_id" => List.first(users).id,
      "manager_id" => manager.id,
      "start_time" => ~U[2021-01-01 08:00:00Z],
      "end_time" => ~U[2021-01-01 16:00:00Z],
      "break_duration" => 30
    }

    working_time1 = %{
      "user_id" => List.first(tl(users)).id,
      "manager_id" => manager.id,
      "start_time" => ~U[2021-02-01 08:00:00Z],
      "end_time" => ~U[2021-02-01 16:00:00Z],
      "break_duration" => 30
    }

    wts = given_existing_wt([working_time, working_time1])

    [users: registred_users, wts: wts]
  end

  # describe "unit WorkingTimeService" do
  #   test "creating working time", %{
  #     users: users
  #   } do
  #     working_time = %{
  #       "user_id" => List.first(users).id,
  #       "manager_id" => List.last(users).id,
  #       "start_time" => ~U[2021-01-01 08:00:00Z],
  #       "end_time" => ~U[2021-01-01 16:00:00Z],
  #       "break_duration" => 30
  #     }
  #
  #     {:ok, working_time} = WorkingTimeService.create_wt(working_time)
  #
  #     IO.inspect(working_time)
  #   end
  # end

  test "creating working time", %{
    conn: conn,
    users: users
  } do
    working_time = %{
      "user_id" => List.first(users).id,
      "start_time" => ~U[2021-01-01 08:00:00Z],
      "end_time" => ~U[2021-01-01 16:00:00Z],
      "break_duration" => 30
    }

    manager = List.last(users)

    conn =
      conn
      |> Auth.put_auth_token(
        Auth.login_pass(manager.email, manager.password)
        |> Auth.extract_auth_token()
      )
      |> post("/api/working_times", %{
        working_time: working_time
      })

    response = Poison.decode!(conn.resp_body)

    # IO.inspect(response)
  end

  test "getting working times", %{
    conn: conn,
    users: users,
    wts: [working_time, working_time1]
  } do
    manager = List.last(users)

    conn =
      conn
      |> Auth.put_auth_token(
        Auth.login_pass(manager.email, manager.password)
        |> Auth.extract_auth_token()
      )
      |> when_getting_wt()
      |> then_wt_should_be_returned([working_time, working_time1])
  end

  test "getting working times by user", %{
    conn: conn,
    users: users,
    wts: [working_time, working_time1]
  } do
    manager = List.last(users)

    conn =
      conn
      |> Auth.put_auth_token(
        Auth.login_pass(manager.email, manager.password)
        |> Auth.extract_auth_token()
      )
      |> get("/api/working_times/#{List.first(users).id}")
      |> then_wt_should_be_returned([working_time])
  end

  test "getting working times by user and time", %{
    conn: conn,
    users: users,
    wts: [working_time, working_time1]
  } do
    manager = List.last(users)

    conn =
      conn
      |> Auth.put_auth_token(
        Auth.login_pass(manager.email, manager.password)
        |> Auth.extract_auth_token()
      )
      |> get("/api/working_times/#{List.first(users).id}/2021-01-01/2021-01-02")
      |> then_wt_should_be_returned([working_time])
  end

  test "updating working time", %{
    conn: conn,
    users: users,
    wts: [working_time, working_time1]
  } do
    manager = List.last(users)

    wt_update = %{
      "start_time" => ~U[2021-01-01 08:30:00Z],
      "break_duration" => 45
    }

    conn =
      conn
      |> Auth.put_auth_token(
        Auth.login_pass(manager.email, manager.password)
        |> Auth.extract_auth_token()
      )
      |> put("/api/working_times/#{working_time.id}", %{
        working_time: wt_update
      })

    response = Poison.decode!(conn.resp_body)

    assert response["start_time"] == "2021-01-01T08:30:00Z"
  end

  test "deleting working time", %{
    conn: conn,
    users: users,
    wts: [working_time, working_time1]
  } do
    manager = List.last(users)

    conn =
      conn
      |> Auth.put_auth_token(
        Auth.login_pass(manager.email, manager.password)
        |> Auth.extract_auth_token()
      )
      |> delete("/api/working_times/#{working_time.id}")

    response = Poison.decode!(conn.resp_body)

    assert conn.status == 204
  end

  @tag :unit
  test "unit : ", %{
    conn: conn,
    users: users
  } do
    manager = List.last(users)

    for i <- 1..10 do
      working_time = %{
        "user_id" => List.first(users).id,
        "manager_id" => manager.id,
        "start_time" => ~U[2021-01-01 08:00:00Z] |> DateTime.add(i * 86400, :second),
        "end_time" => ~U[2021-01-01 09:00:00Z] |> DateTime.add(i * 86400, :second),
        "break_duration" => 30
      }

      {:ok, working_time} = WorkingTimeService.create_wt(working_time)
    end

    # working_times =
    #   WorkingTimeService.get_wt_by_user_by_range(
    #     List.first(users).id,
    #     "2020-01-01",
    #     "2022-01-10"
    #   )
    #   |> IO.inspect()

    conn =
      conn
      |> Auth.put_auth_token(
        Auth.login_pass(manager.email, manager.password)
        |> Auth.extract_auth_token()
      )
      |> get("/api/working_times/stats/#{List.first(users).id}/2020-01-01/2022-01-10")

    response = Poison.decode!(conn.resp_body)
  end
end
