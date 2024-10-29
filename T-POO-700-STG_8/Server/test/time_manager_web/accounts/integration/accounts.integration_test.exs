defmodule TimeManagerWeb.AccountsTest do
  use TimeManagerWeb.ConnCase, async: true
  import TimeManagerWeb.Test.UserBuilder
  alias TimeManager.Test.SetupFixture.{Registration, Auth, Authorization, Accounts}
  alias TimeManager.Test.AccountsFixture

  @moduletag :integration
  @moduletag :accounts

  @admin user()
         |> with_email("admin1@gmail.com")
         |> with_username("Monsieur Admin")
         |> with_password("MAIS LOL")
         |> with_role("admin")

  @user user()
        |> with_email("user1@gmail.com")
        |> with_username("User 1")
        |> with_password("MAIS LOL")

  @manager user()
           |> with_email("manager1@gmail.com")
           |> with_username("Manager 1")
           |> with_password("MAIS LOL")
           |> with_role("manager")

  describe "As a an Admin, " do
    test "I have an admin role" do
      Registration.given_existing_users([@admin])
      Authorization.assert_user_role(@admin["email"], :admin)
    end

    test "I can update any user's profile", %{conn: conn} do
      registred_users = Registration.given_existing_users([@user, @admin])
      # User id (because @user is the first in the list)
      user_id = Enum.at(registred_users, 1).id
      admin_response = Auth.login_pass(@admin["email"], @admin["password"])
      admin_token = Auth.extract_auth_token(admin_response)

      updated_user_params = @user |> with_username("User updated") |> with_role("manager")

      conn
      |> Auth.put_auth_token(admin_token)
      |> AccountsFixture.update_user(updated_user_params, user_id)
      |> AccountsFixture.then_user_is_updated(updated_user_params)
    end

    test "I can update any manager's profile", %{conn: conn} do
      registred_users = Registration.given_existing_users([@manager, @admin])
      manager_id = Enum.at(registred_users, 1).id
      admin_response = Auth.login_pass(@admin["email"], @admin["password"])
      admin_token = Auth.extract_auth_token(admin_response)
      updated_manager_params = @manager |> with_username("Manager 2")

      conn
      |> Auth.put_auth_token(admin_token)
      |> AccountsFixture.update_user(updated_manager_params, manager_id)
      |> AccountsFixture.then_user_is_updated(updated_manager_params)
    end

    test "I can see all users", %{conn: conn} do
      registred_users =
        Registration.given_existing_users([
          @user,
          @user |> with_email("user2@gmail.com") |> with_username("User 2"),
          @user |> with_email("user3@gmail.com") |> with_username("User 3"),
          @user |> with_email("user4@gmail.com") |> with_username("User 4"),
          @admin
        ])

      admin_response = Auth.login_pass(@admin["email"], @admin["password"])
      admin_token = Auth.extract_auth_token(admin_response)

      conn
      |> Auth.put_auth_token(admin_token)
      |> AccountsFixture.get_users()
      |> AccountsFixture.then_registered_users_are(registred_users)
    end

    @tag :this2
    test "I can create a user", %{conn: conn} do
      registred_users = Registration.given_existing_users([@admin, @manager])

      admin_response = Auth.login_pass(@admin["email"], @admin["password"])
      admin_token = Auth.extract_auth_token(admin_response)

      conn =
        conn
        |> Auth.put_auth_token(admin_token)

      user = user(6) |> with_manager_id(Enum.at(registred_users, 1).id)

      conn
      |> AccountsFixture.create_user(user)
      |> AccountsFixture.then_user_is_created(user)
    end

    test "I can delete a user", %{conn: conn} do
      registred_users = Registration.given_existing_users([@user, @admin])

      user_id = Enum.at(registred_users, 1).id

      admin_response = Auth.login_pass(@admin["email"], @admin["password"])
      admin_token = Auth.extract_auth_token(admin_response)

      conn
      |> Auth.put_auth_token(admin_token)
      |> AccountsFixture.delete_user(user_id)
      |> AccountsFixture.then_user_is_deleted()
    end
  end

  describe "As a an User, " do
    test "I have an user role" do
      Registration.given_existing_users([@user])
      Authorization.assert_user_role(@user["email"], :user)
    end

    test "I can update my profile", %{conn: conn} do
      registered_users = Registration.given_existing_users([@user, @manager])

      _manager = List.first(registered_users)

      user_response = Auth.login_pass(@user["email"], @user["password"])
      token = Auth.extract_auth_token(user_response)

      updated_user = @user |> with_username("User 2") |> Map.drop(["role", "manager_id"])

      conn
      |> Auth.put_auth_token(token)
      |> AccountsFixture.update_user(updated_user, user_response.user.id)
      |> AccountsFixture.then_user_is_updated(@user |> with_username("User 2"))
    end

    test "I can't update my role", %{conn: conn} do
      registered_users = Registration.given_existing_users([@user, @manager])

      _manager = List.first(registered_users)

      user_response = Auth.login_pass(@user["email"], @user["password"])
      token = Auth.extract_auth_token(user_response)

      updated_user = @user |> with_role("manager")

      conn
      |> Auth.put_auth_token(token)
      |> AccountsFixture.update_user(updated_user, user_response.user.id)
      |> AccountsFixture.request_is_forbidden()
    end

    test "I can't update my manager", %{conn: conn} do
      registered_users = Registration.given_existing_users([@user, @manager])

      manager = List.first(registered_users)

      user_response = Auth.login_pass(@user["email"], @user["password"])
      token = Auth.extract_auth_token(user_response)

      updated_user = @user |> with_manager_id(manager.id)

      conn
      |> Auth.put_auth_token(token)
      |> AccountsFixture.update_user(updated_user, user_response.user.id)
      |> AccountsFixture.request_is_forbidden()
    end

    test "I can't update another user's profile", %{conn: conn} do
      user2 = @user |> with_email("user2@gmail.com") |> with_username("User 2")
      registred_users = Registration.given_existing_users([@user, user2])
      user1_response = Auth.login_pass(@user["email"], @user["password"])
      user2_id = Enum.at(registred_users, 0).id
      user1_token = Auth.extract_auth_token(user1_response)
      updated_user_params = @user |> with_username("User 3")

      conn
      |> Auth.put_auth_token(user1_token)
      |> AccountsFixture.update_user(updated_user_params, user2_id)
      |> AccountsFixture.request_is_forbidden()
    end

    test "I can't see all users", %{conn: conn} do
      _registred_users =
        Registration.given_existing_users([
          @user,
          @user |> with_email("user2@gmail.com") |> with_username("User 2"),
          @user |> with_email("user3@gmail.com") |> with_username("User 3"),
          @user |> with_email("user4@gmail.com") |> with_username("User 4"),
          @admin
        ])

      user_response = Auth.login_pass(@user["email"], @user["password"])
      user_token = Auth.extract_auth_token(user_response)

      conn
      |> Auth.put_auth_token(user_token)
      |> AccountsFixture.get_users()
      |> AccountsFixture.request_is_forbidden()
    end

    test "I can't create a user", %{conn: conn} do
      registred_users = Registration.given_existing_users([@user])

      user_response = Auth.login_pass(@user["email"], @user["password"])
      user_token = Auth.extract_auth_token(user_response)

      conn =
        conn
        |> Auth.put_auth_token(user_token)

      user = user(6)

      conn
      |> AccountsFixture.create_user(user)
      |> AccountsFixture.request_is_forbidden()
    end

    test "I can delete my account", %{conn: conn} do
      registred_users = Registration.given_existing_users([@user, @admin])

      user_id = Enum.at(registred_users, 1).id

      user_response = Auth.login_pass(@user["email"], @user["password"])
      user_token = Auth.extract_auth_token(user_response)

      conn
      |> Auth.put_auth_token(user_token)
      |> AccountsFixture.delete_user(user_id)
      |> AccountsFixture.then_user_is_deleted()
    end

    test "I can't delete any other account", %{conn: conn} do
      registred_users = Registration.given_existing_users([@user, user(5)])

      user_id = Enum.at(registred_users, 1).id
      user5_id = Enum.at(registred_users, 0).id

      user_response = Auth.login_pass(@user["email"], @user["password"])
      user_token = Auth.extract_auth_token(user_response)

      conn
      |> Auth.put_auth_token(user_token)
      |> AccountsFixture.delete_user(user5_id)
      |> AccountsFixture.request_is_forbidden()
    end
  end

  describe "As a a Manager, " do
    test "I have an manager role" do
      Registration.given_existing_users([@manager])

      Authorization.assert_user_role(@manager["email"], :manager)
    end

    test "I can update my profile", %{conn: conn} do
      registered_users = Registration.given_existing_users([@user, @manager])

      _manager = List.first(registered_users)

      manager_response = Auth.login_pass(@manager["email"], @manager["password"])
      token = Auth.extract_auth_token(manager_response)

      updated_manager = @manager |> with_username("Manager 2") |> Map.drop(["role", "manager_id"])

      conn
      |> Auth.put_auth_token(token)
      |> AccountsFixture.update_user(updated_manager, manager_response.user.id)
      |> AccountsFixture.then_user_is_updated(@manager |> with_username("Manager 2"))
    end

    test "I can't update my role", %{conn: conn} do
      registered_users = Registration.given_existing_users([@user, @manager])

      _manager = List.first(registered_users)

      manager_response = Auth.login_pass(@manager["email"], @manager["password"])
      token = Auth.extract_auth_token(manager_response)

      updated_manager = @manager |> with_role("admin")

      conn
      |> Auth.put_auth_token(token)
      |> AccountsFixture.update_user(updated_manager, manager_response.user.id)
      |> AccountsFixture.request_is_forbidden()
    end

    test "I can't update my manager", %{conn: conn} do
      registered_users = Registration.given_existing_users([@user, @manager])

      manager = List.first(registered_users)

      manager_response = Auth.login_pass(@manager["email"], @manager["password"])
      token = Auth.extract_auth_token(manager_response)

      updated_manager = @manager |> with_manager_id(manager.id)

      conn
      |> Auth.put_auth_token(token)
      |> AccountsFixture.update_user(updated_manager, manager_response.user.id)
      |> AccountsFixture.request_is_forbidden()
    end

    test "I can see all users that are assigned to me", %{conn: conn} do
      registred_users =
        Registration.given_existing_users([
          @user,
          @user |> with_email("user2@gmail.com") |> with_username("User 2"),
          @user |> with_email("user3@gmail.com") |> with_username("User 3"),
          @user |> with_email("user4@gmail.com") |> with_username("User 4"),
          @manager
        ])

      manager = hd(registred_users)

      tl(registred_users)
      |> Enum.map(fn user ->
        updated_user = %{manager_id: manager.id}
        Accounts.update_user(user, updated_user)
        user
      end)

      # User 6 pas assignee (pour tester ..)
      Registration.given_existing_users([user(6)])

      manager_response = Auth.login_pass(@manager["email"], @manager["password"])
      manager_token = Auth.extract_auth_token(manager_response)

      conn
      |> Auth.put_auth_token(manager_token)
      |> AccountsFixture.get_users()
      |> AccountsFixture.then_users_got_are(tl(registred_users))
    end

    test "I can't create a user", %{conn: conn} do
      registred_users = Registration.given_existing_users([@manager])

      manager_response = Auth.login_pass(@manager["email"], @manager["password"])
      manager_token = Auth.extract_auth_token(manager_response)

      conn =
        conn
        |> Auth.put_auth_token(manager_token)

      user = user(6)

      conn
      |> AccountsFixture.create_user(user)
      |> AccountsFixture.request_is_forbidden()
    end

    test "I can't delete a user", %{conn: conn} do
      registred_users = Registration.given_existing_users([@user, @manager])

      user_id = Enum.at(registred_users, 1).id

      manager_response = Auth.login_pass(@manager["email"], @manager["password"])
      manager_token = Auth.extract_auth_token(manager_response)

      conn
      |> Auth.put_auth_token(manager_token)
      |> AccountsFixture.delete_user(user_id)
      |> AccountsFixture.request_is_forbidden()
    end
  end
end
