defmodule TimeManager.Fixture.AuthFixture do
  use TimeManagerWeb.ConnCase
  alias TimeManager.Accounts.{Application.ManageUserService}

  def login_pass(conn, %{email: email, password: password}) do
    post(conn, ~p"/api/auth/", %{email: email, password: password})
  end

  def login_token(conn, token) do
    conn
    |> put_req_header("authorization", "Bearer " <> token)
    |> get(~p"/api/auth/me")
  end

  def given_existing_users(data) do
    for user <- data do
      ManageUserService.create_user(user)
    end
  end

  def given_authenticated_user(conn, user) do
    given_existing_users([user])

    conn = login_pass(conn, %{email: user["email"], password: user["password"]})
    _response_token = json_response(conn, 200)["token"]
  end

  def assert_is_the_same_user(conn, user) do
    assert conn.status == 200
    response_user = json_response(conn, 200)["user"]
    _response_token = json_response(conn, 200)["token"]

    assert response_user["email"] == user["email"]
    assert response_user["username"] == user["username"]
  end

  def assert_i_receive_a_token(conn) do
    assert conn.status == 200
    response_token = json_response(conn, 200)["token"]
    assert response_token != nil
  end

  def assert_error(conn, error) do
    assert conn.status == error["status"]
    response_body_error = Jason.decode!(conn.resp_body)["errors"]
    assert response_body_error["detail"] == error["detail"]
  end
end
