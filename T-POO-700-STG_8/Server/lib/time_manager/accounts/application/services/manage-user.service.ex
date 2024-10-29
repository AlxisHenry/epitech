defmodule TimeManager.Accounts.Application.ManageUserService do
  use TimeManager, :application_service

  alias TimeManager.Accounts.{UserModel, Infrastructure.UserRepository}

  @self __MODULE__

  def get_users() do
    UserRepository.get_all()
  end

  def get_user_by_id(id) do
    case UserRepository.get_by_id(id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  def get_user_by_email_and_username(email, username) do
    case UserRepository.get_by_email_and_username(email, username) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  def get_user_by_email(email) do
    case UserRepository.get_by_email(email) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  def get_users_by_manager(manager_id) do
    UserRepository.get_all_by_manager(manager_id)
  end

  def create_user(params) do
    %UserModel{}
    |> UserModel.changeset(params)
    |> UserRepository.insert()
  end

  def update_user(user, update_user) do
    user
    |> UserModel.changeset_update(update_user)
    |> UserRepository.update(update_user)
  end

  def delete_user(user) do
    user
    |> UserRepository.delete()
  end

  def is_my_user?(user_id, manager_id) do
    case @self.get_user_by_id(user_id) do
      {:ok, user} when user.manager_id == manager_id -> :ok
      _ -> false
    end
  end
end
