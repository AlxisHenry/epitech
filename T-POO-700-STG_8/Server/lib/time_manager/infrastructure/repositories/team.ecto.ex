defmodule TimeManager.TimeTracking.Infrastructure.TeamRepository do
  use TimeManager, :repository

  alias TimeManager.TimeTracking.TeamModel
  alias TimeManager.Accounts.UserModel

  alias TimeManager.TimeTracking.Application.TeamRepository

  alias Ecto.Changeset
  alias Ecto.UUID

  @behaviour TeamRepository

  @impl true
  def get_all() do
    TeamModel
    |> Repo.all()
    |> Repo.preload(:manager)
    |> Repo.preload(:users)
  end

  @impl true
  def get_all(manager_id) do
    from(t in TeamModel, where: t.manager_id == ^manager_id)
    |> Repo.all()
    |> Repo.preload(:manager)
    |> Repo.preload(:users)
  end

  @impl true
  def get_by_id(id) do
    if Repo.is_uuid(id) do
      TeamModel
      |> Repo.get(id)
      |> Repo.preload(:manager)
      |> Repo.preload(:users)
    end
  end

  @impl true
  def insert(team) do
    with {:ok, team} <- Repo.insert(team) do
      {:ok, Repo.preload(team, :manager)}
    end
  end

  @impl true
  def get_by_manager(manager_id) do
    TeamModel
    |> Repo.get_by(UserModel, manager_id: manager_id)
  end

  @impl true
  def get_by_user(user_id) do
    case UUID.dump(user_id) do
      {:ok, user_id} ->
        query =
          from t in TeamModel,
            join: tu in "teams_users",
            on: t.id == tu.team_id,
            where: tu.user_id == ^user_id

        query
        |> Repo.all()

      _ ->
        {:error, :invalid_team_id}
    end
  end

  @impl true
  def update(team, params) do
    team
    |> TeamModel.changeset(params)
    |> Repo.update()
  end

  @impl true
  def delete(team_id) do
    case UUID.dump(team_id) do
      {:ok, team_uuid} ->
        from(u in "teams_users", where: u.team_id == ^team_uuid)
        |> Repo.delete_all()

        TeamModel
        |> Repo.get!(team_id)
        |> Repo.delete()

      _ ->
        {:error, :invalid_team_id}
    end
  end

  @impl true
  def delete_user(team, user_id) do
    user =
      UserModel
      |> Repo.get!(user_id)

    can_update =
      team.users
      |> Enum.find(fn u -> u.id == user.id end) != nil

    with true <- can_update do
      team
      |> Changeset.change()
      |> Changeset.put_assoc(:users, Enum.reject(team.users, fn u -> u.id == user.id end))
      |> Repo.update()
    else
      false ->
        {:error, :not_in_team}
    end
  end

  @impl true
  def add_user(team, user_id) do
    team =
      TeamModel
      |> Repo.get(team.id)
      |> Repo.preload(:users)
      |> Repo.preload(:manager)

    user =
      UserModel
      |> Repo.get!(user_id)

    can_update =
      team.users
      |> Enum.find(fn u -> u.id == user.id end) == nil

    with true <- can_update do
      team
      |> Changeset.change()
      |> Changeset.put_assoc(:users, [user | team.users])
      |> Repo.update()
    else
      false ->
        {:error, :already_in_team}
    end
  end
end
