defmodule TimeManager.Test.AccountsFixture do
  use TimeManagerWeb.ConnCase

  alias TimeManager.Accounts.Application.UserRepository

  def get_users(conn) do
    get(conn, "/api/users")
  end

  def update_user(conn, user, user_id) do
    put(conn, ~p"/api/users/#{user_id}", %{user: user})
  end

  def create_user(conn, user) do
    post(conn, "/api/users", %{user: user})
  end

  def delete_user(conn, user_id) do
    delete(conn, ~p"/api/users/#{user_id}")
  end

  def then_user_is_created(conn, user) do
    response_user = Poison.decode!(conn.resp_body)

    assert conn.status == 201

    assert response_user["email"] == user["email"]
    assert response_user["username"] == user["username"]
    assert response_user["id"] != nil
  end

  def then_user_is_deleted(conn) do
    assert conn.status == 204
  end

  def then_user_is_updated(conn, user) do
    response_user = Poison.decode!(conn.resp_body)

    assert conn.status == 200
    assert response_user["email"] == user["email"]
    assert response_user["username"] == user["username"]
  end

  def request_is_forbidden(conn) do
    assert conn.status == 403
  end

  def then_registered_users_are(conn, users) do
    response_users = Poison.decode!(conn.resp_body)
    response_users = Map.get(response_users, "data")

    assert conn.status == 200

    assert Enum.count(response_users) == Enum.count(users)

    assert Enum.all?(users, fn user ->
             Enum.any?(response_users, fn response_user ->
               response_user["email"] == user.email &&
                 response_user["username"] == user.username &&
                 response_user["id"] == user.id
             end)
           end)
  end

  def then_users_got_are(conn, users) do
    response_users = Poison.decode!(conn.resp_body)
    response_users = Map.get(response_users, "data")

    assert conn.status == 200

    assert Enum.count(response_users) == Enum.count(users)

    assert Enum.all?(users, fn user ->
             Enum.any?(response_users, fn response_user ->
               response_user["email"] == user.email &&
                 response_user["username"] == user.username &&
                 response_user["id"] == user.id
             end)
           end)
  end
end
