defmodule TimeManager.Accounts.Application.PasswordHasher do
  alias Bcrypt.Base

  @spec hash(String.t()) :: String.t()
  def hash(password) do
    password
    |> Base.hash_password(Base.gen_salt(Application.get_env(:bcrypt_elixir, :log_rounds)))
  end

  @spec verify_password(String.t(), String.t()) :: boolean()
  def verify_password(password, stored_hash) do
    password
    |> Bcrypt.verify_pass(stored_hash)
  end
end
