defmodule TimeManager.Accounts.Application.Token do
  # @day_in_seconds 86_400

  use Joken.Config

  @self __MODULE__

  def sign(data) do
    @self.generate_and_sign!(data)
  end

  def verify(token) do
    @self.verify_and_validate(token)
  end
end
