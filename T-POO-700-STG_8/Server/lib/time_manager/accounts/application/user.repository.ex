defmodule TimeManager.Accounts.Application.UserRepository do
  @self __MODULE__

  defp adapter() do
    Application.get_env(:time_manager, @self)
  end

  @callback get_all() :: [UserModel.t()] | {:error, any()}
  @callback get_by_id(id :: String.t()) :: UserModel.t() | nil
  @callback insert(user :: UserModel.t()) :: {:ok, UserModel.t()} | {:error, any()}
  @callback get_by_email_and_username(email :: String.t(), username :: String.t()) ::
              UserModel.t() | nil
  @callback get_by_email(email :: String.t()) :: UserModel.t() | nil
  @callback update(user :: UserModel.t(), params :: map()) ::
              {:ok, UserModel.t()} | {:error, any()}
  @callback delete(user :: UserModel.t()) :: {:ok, UserModel.t()} | {:error, any()}

  def insert(user), do: adapter().insert(user)
  def get_all(), do: adapter().get_all()
  def get_by_id(id), do: adapter().get_by_id(id)

  def get_by_email_and_username(email, username),
    do: adapter().get_by_email_and_username(email, username)

  def get_by_email(email), do: adapter().get_by_email(email)
  def update(user, params), do: adapter().update(user, params)
  def delete(user), do: adapter().delete(user)
end
