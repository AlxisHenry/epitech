defmodule TimeManagerWeb.Test.UserBuilder do
  def user do
    %{
      "username" => "test",
      "email" => "test@gmail.com",
      "password" => "password",
      "role" => "user",
      "manager_id" => nil
    }
  end

  def with_username(user, username) do
    %{user | "username" => username}
  end

  def with_email(user, email) do
    %{user | "email" => email}
  end

  def with_password(user, password) do
    %{user | "password" => password}
  end

  def invalid_user do
    %{
      "username" => "test"
    }
  end

  def with_role(user, role) do
    %{user | "role" => role}
  end

  def with_manager_id(user, manager_id) do
    %{user | "manager_id" => manager_id}
  end

  def user(number, role \\ :user) do
    case role do
      :user ->
        the_user = "User#{number}"

        user()
        |> with_username(the_user)
        |> with_email("#{the_user}@gmail.com")
        |> with_role("user")

      :admin ->
        the_user = "Admin#{number}"

        user()
        |> with_username(the_user)
        |> with_email("#{the_user}@gmail.com")
        |> with_role("admin")

      :manager ->
        the_user = "Manager#{number}"

        user()
        |> with_username(the_user)
        |> with_email("#{the_user}@gmail.com")
        |> with_role("manager")

      _ ->
        nil
    end
  end
end
