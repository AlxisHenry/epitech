defmodule TimeManager.Repo.Migrations.CreateWorkingTimes do
  use Ecto.Migration

  def change do
    create table(:working_times, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :break_duration, :integer
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)
      add :manager_id, references(:users, type: :binary_id, on_delete: :delete_all)

      timestamps()
    end

    create index(:working_times, [:user_id])
    create index(:working_times, [:manager_id])
  end
end
