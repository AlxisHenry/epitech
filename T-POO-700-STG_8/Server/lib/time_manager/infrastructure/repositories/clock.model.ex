defmodule TimeManager.TimeTracking.ClockModel do
  use TimeManager, :domain_model

  # alias TimeManager.Accounts.UserModel

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clocks" do
    field :time, :utc_datetime
    field :status, Ecto.Enum, values: [:clock_in, :clock_out]
    field :user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:status, :user_id, :time])
    |> validate_required([:status, :user_id, :time])
  end
end
