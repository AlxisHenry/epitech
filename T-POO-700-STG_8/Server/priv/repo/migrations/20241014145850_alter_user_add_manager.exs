defmodule TimeManager.Repo.Migrations.AlterUserAddManager do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :manager_id, references(:users, type: :binary_id), null: true
    end

    create index(:users, [:manager_id])
  end
end
