defmodule TimeManager.Repo.Migrations.AlterClocksTable do
  use Ecto.Migration

  def change do
    alter table(:clocks) do
      add :time, :utc_datetime, null: false
      add :status, :string, null: false

      remove :start_time
      remove :end_time
    end
  end
end
