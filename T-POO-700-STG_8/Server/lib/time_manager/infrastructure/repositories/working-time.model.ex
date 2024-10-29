defmodule TimeManager.TimeTracking.WorkingTimeModel do
  use TimeManager, :domain_model

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "working_times" do
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime
    field :break_duration, :integer
    field :user_id, :binary_id
    field :manager_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  def changeset(working_time, params) do
    working_time
    |> cast(params, [:start_time, :end_time, :break_duration, :user_id, :manager_id])
    |> validate_required([:start_time, :end_time, :break_duration, :user_id, :manager_id])
  end

  def changeset_update(working_time, params) do
    working_time
    |> cast(params, [:start_time, :end_time, :break_duration, :user_id, :manager_id])
  end
end
