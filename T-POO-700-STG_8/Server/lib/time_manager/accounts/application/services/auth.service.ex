defmodule TimeManager.Accounts.Application.AuthService do
  use TimeManager, :application_service

  alias TimeManager.Accounts.Application.UserRepository
  alias TimeManager.Accounts.Application.{ManageUserService, PasswordHasher, Token}

  alias PasswordHasher

  def login(%{"email" => email, "password" => password}) do
    case UserRepository.get_by_email(email) do
      nil ->
        {:error, :user_not_found}

      user ->
        authenticate_with_password(user, password)
    end
  end

  def auth_with_token(token) do
    with {:ok, data} <- Token.verify(token),
         {:ok, user} = ManageUserService.get_user_by_id(data["id"]) do
      {:ok, user}
    end
  end

  defp authenticate_with_password(user, password) do
    with true <- PasswordHasher.verify_password(password, user.password_hash) do
      {:ok, user}
    else
      false -> {:error, :invalid_password}
    end
  end
end
