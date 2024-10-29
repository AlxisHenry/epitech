defmodule TimeManager.Test.SetupFixture do
  use TimeManagerWeb.ConnCase
  alias TimeManager.Accounts.Application.ManageUserService
  alias TimeManager.Accounts.Application.AuthService
  alias TimeManager.Accounts.Infrastructure.UserPresenter

  defmodule Registration do
    def given_existing_users(users) when is_list(users) do
      Enum.reduce(users, [], fn user, acc ->
        case ManageUserService.create_user(user) do
          {:ok, user_model} -> [user_model | acc]
          {:error, _reason} -> acc
        end
      end)
    end
  end

  defmodule Auth do
    def login_pass(email, mdp) do
      with {:ok, user} <- AuthService.login(%{"email" => email, "password" => mdp}) do
        UserPresenter.present_auth_user(%{user: user})
      end
    end

    def login_token(token) do
      with {:ok, user} <- AuthService.auth_with_token(token) do
        {:ok, user}
      end
    end

    def extract_auth_token(resp) do
      resp.token
    end

    def put_auth_token(conn, token) do
      conn
      |> put_req_header("authorization", "Bearer " <> token)
    end
  end

  defmodule Authorization do
    def assert_user_role(email, role) do
      with {:ok, user} <- ManageUserService.get_user_by_email(email) do
        assert user.role == role
      end
    end

    def assert_action_is_forbiden(conn) do
      assert conn.status == 403
    end
  end

  defmodule Accounts do
    def update_user(user, updated_user) do
      ManageUserService.update_user(user, updated_user)
    end
  end
end
