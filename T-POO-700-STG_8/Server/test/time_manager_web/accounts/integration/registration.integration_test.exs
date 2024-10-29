defmodule TimeManagerWeb.RegisterControllerTest do
  use TimeManagerWeb.ConnCase, async: true
  alias TimeManager.Accounts.Application.UserRepository
  alias TimeManagerWeb.Test.UserBuilder

  @moduletag :registration
  @moduletag :integration

  test "As an unregistered user, I can register with a username and an email", %{conn: conn} do
    conn = register(conn, UserBuilder.user())

    assert conn.status == 201

    user = UserRepository.get_by_email("test@gmail.com")

    assert user.email == user.email
    assert user.username == user.username
    assert user.password_hash != user.password
  end

  test "As an unregistered user, I can't register with an invalid email", %{conn: conn} do
    conn =
      register(
        conn,
        UserBuilder.user()
        |> UserBuilder.with_email("aa")
      )

    conn
    |> assert_changeset_error(422, %{
      "errors" => %{"email" => ["has invalid format"]}
    })
  end

  test "As an unregistered user, I can't register with an invalid username", %{conn: conn} do
    conn =
      register(
        conn,
        UserBuilder.user()
        |> UserBuilder.with_username("aa")
      )

    conn
    |> assert_changeset_error(422, %{
      "errors" => %{"username" => ["should be at least 3 character(s)"]}
    })
  end

  test "As an unregistered user, I can't register with an invalid password", %{conn: conn} do
    conn =
      register(
        conn,
        UserBuilder.user()
        |> UserBuilder.with_password("aa")
      )

    conn
    |> assert_changeset_error(422, %{
      "errors" => %{"password" => ["should be at least 8 character(s)"]}
    })
  end

  test "As a registered user, I can't register with the same email", %{conn: conn} do
    register(conn, UserBuilder.user())

    conn =
      register(
        conn,
        UserBuilder.user()
        |> UserBuilder.with_username("another_username")
      )

    conn
    |> assert_changeset_error(422, %{
      "errors" => %{"email" => ["has already been taken"]}
    })
  end

  test "The registration endpoint doesnt work with a blank field", %{conn: conn} do
    conn =
      register(conn, %{})

    conn
    |> assert_changeset_error(422, %{
      "errors" => %{
        "email" => ["can't be blank"],
        "password" => ["can't be blank"],
        "username" => ["can't be blank"]
      }
    })
  end

  defp register(conn, user) do
    post(conn, ~p"/api/registration", user)
  end

  defp assert_changeset_error(conn, status, changeset_message_error) do
    assert conn.status == status
    assert Jason.decode!(conn.resp_body) == changeset_message_error
  end
end
