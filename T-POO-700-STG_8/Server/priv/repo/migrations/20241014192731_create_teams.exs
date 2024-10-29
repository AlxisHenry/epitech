defmodule TimeManager.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false

      add :manager_id, references(:users, type: :binary_id, on_delete: :nothing)

      timestamps(type: :utc_datetime_usec)
    end

    create table(:teams_users, primary_key: false) do
      add :team_id, references(:teams, type: :binary_id, on_delete: :nothing)
      add :user_id, references(:users, type: :binary_id, on_delete: :nothing)
    end

    create unique_index(:teams_users, [:user_id, :team_id])
    # create index(:teams, [:manager_id])
    # create index(:teams, [:user_id])
    #
    # create index(:teams_users, [:team_id])
    # create index(:teams_users, [:user_id])
    #
    # create unique_index(:teams_users, [:team_id, :user_id])
  end
end
