defmodule TimeManager.Accounts.Infrastructure.UserPresenter do
  alias TimeManager.Accounts.UserModel
  alias TimeManager.Accounts.Application.Token

  def present_user(%{user: %UserModel{} = user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role,
      manager: present_manager(user.manager)
    }
  end

  def present_users(%{users: users}) do
    %{data: for(user <- users, do: present_user(%{user: user}))}
  end

  def present_auth_user(%{user: %UserModel{} = user}) do
    user = present_user(%{user: user})

    %{
      user: user,
      token: Token.sign(user)
    }
  end

  def present_manager(manager) do
    case manager do
      %UserModel{} ->
        %{
          id: manager.id,
          username: manager.username,
          email: manager.email
        }

      _ ->
        nil
    end
  end

  def present_user_without_manager(%{user: %UserModel{} = user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role
    }
  end

  def present_users_without_manager(%{users: users}) do
    case users do
      %Ecto.Association.NotLoaded{} ->
        []

      _ ->
        %{data: for(user <- users, do: present_user_without_manager(%{user: user}))}
    end
  end
end
