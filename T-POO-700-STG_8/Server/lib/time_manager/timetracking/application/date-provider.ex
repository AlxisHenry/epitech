defmodule TimeManager.TimeTracking.Application.DateProvider do
  defp adapter() do
    Application.get_env(:time_manager, :date_provider)
  end

  @callback now() :: DateTime.t()

  def now do
    adapter().now()
  end
end

defmodule TimeManager.TimeTracking.Infrastructure.DateProvider do
  alias TimeManager.TimeTracking.Application.DateProvider

  @behaviour DateProvider

  @impl true
  def now do
    DateTime.utc_now()
  end
end

defmodule TimeManager.Test.FakeDateProvider do
  alias TimeManager.TimeTracking.Application.DateProvider

  defp plus_value() do
    Application.get_env(:time_manager, :fake_date_provider)
  end

  @behaviour DateProvider

  @impl true
  def now do
    DateTime.utc_now()
    |> DateTime.add(plus_value())
  end
end
