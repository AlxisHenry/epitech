defmodule TimeManagerWeb.AuthControllerTest do
  use TimeManagerWeb.ConnCase, async: true
  alias TimeManagerWeb.Test.UserBuilder
  alias TimeManager.Fixture.AuthFixture

  @moduletag :integration
  @moduletag :auth

  describe "As a registered user, being unauthentificated " do
    test "I can login with my email and password", %{conn: conn} do
      user = UserBuilder.user() |> UserBuilder.with_password("MAIS LOL")
      AuthFixture.given_existing_users([user])

      conn = AuthFixture.login_pass(conn, %{email: user["email"], password: user["password"]})

      AuthFixture.assert_is_the_same_user(conn, user)
    end

    test "I receive a token when i log in", %{conn: conn} do
      user = UserBuilder.user() |> UserBuilder.with_password("MAIS LOL")
      AuthFixture.given_existing_users([user])

      conn = AuthFixture.login_pass(conn, %{email: user["email"], password: user["password"]})
      conn |> AuthFixture.assert_i_receive_a_token()
    end

    test "I can't login with an invalid email", %{conn: conn} do
      user = UserBuilder.user() |> UserBuilder.with_password("MAIS LOL")
      AuthFixture.given_existing_users([user])

      conn
      |> AuthFixture.login_pass(%{email: "aa", password: user["password"]})
      |> AuthFixture.assert_error(%{"status" => 404, "detail" => "Resource not found"})
    end

    test "I can't login with an wrong password", %{conn: conn} do
      user = UserBuilder.user()
      AuthFixture.given_existing_users([user])

      conn
      |> AuthFixture.login_pass(%{email: user["email"], password: "wrong_password"})
      |> AuthFixture.assert_error(%{"status" => 401, "detail" => "Unauthorized"})
    end
  end

  describe "As an authenticated user" do
    test "I can login with my token", %{conn: conn} do
      response_token = AuthFixture.given_authenticated_user(conn, UserBuilder.user())

      conn
      |> AuthFixture.login_token(response_token)
      |> AuthFixture.assert_is_the_same_user(UserBuilder.user())
    end
  end
end
