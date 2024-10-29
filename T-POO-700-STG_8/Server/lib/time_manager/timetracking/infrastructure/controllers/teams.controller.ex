defmodule TimeManagerWeb.TimeTracking.Infrastructure.TeamsController do
  use TimeManagerWeb, :controller

  action_fallback TimeManagerWeb.FallbackController

  alias TimeManager.TimeTracking.Infrastructure.TeamPresenter
  alias TimeManager.TimeTracking.Application.TeamService

  def get_teams(conn, _params) do
    user_assigns = conn.assigns[:current_user]

    basic_authorization = Bodyguard.permit(TimeManager.Teams, :get_teams, user_assigns)

    with :ok <- basic_authorization do
      case user_assigns do
        %{role: :admin} ->
          case TeamService.get_teams() do
            {:ok, teams} ->
              conn
              |> TeamPresenter.render_result(teams, :ok)

            {:error, _reason} ->
              conn
              |> TeamPresenter.render_error("500.json", :internal_server_error)
          end

        %{role: :manager, id: manager_id} ->
          case TeamService.get_teams(manager_id) do
            {:ok, teams} ->
              conn
              |> TeamPresenter.render_result(teams, :ok)

            {:error, _reason} ->
              conn
              |> TeamPresenter.render_error("500.json", :internal_server_error)
          end
      end
    else
      _ ->
        conn
        |> TeamPresenter.render_error("403.json", :forbidden)
    end
  end

  def get_team(conn, %{"team_id" => team_id}) do
    user_assigns = conn.assigns[:current_user]

    basic_authorization =
      Bodyguard.permit(TimeManager.Teams, :get_team, user_assigns, %{"team_id" => team_id})

    with :ok <- basic_authorization do
      case TeamService.get_team_by_id(team_id) do
        {:ok, team} ->
          conn
          |> TeamPresenter.render_result(team, :ok)

        {:error, _reason} ->
          conn
          |> TeamPresenter.render_error("404.json", :not_found)
      end
    else
      _ ->
        conn
        |> TeamPresenter.render_error("403.json", :forbidden)
    end
  end

  def get_team(conn, _params) do
    conn
    |> TeamPresenter.render_error("400.json", :bad_request)
  end

  def create_team(conn, team_params) do
    user_assigns = conn.assigns[:current_user]

    basic_authorization =
      Bodyguard.permit(TimeManager.Teams, :create_team, user_assigns, team_params["team"])

    with :ok <- basic_authorization do
      case TeamService.create_team(team_params["team"]) do
        {:ok, team} ->
          conn
          |> TeamPresenter.render_result(team, :created)

        {:error, _reason} ->
          conn
          |> TeamPresenter.render_error("500.json", :internal_server_error)
      end
    else
      _ ->
        conn
        |> TeamPresenter.render_error("403.json", :forbidden)
    end
  end

  def add_user_to_team(conn, user_params) do
    user_assigns = conn.assigns[:current_user]
    team_id = conn.params["team_id"]
    user_id = user_params["user_id"]

    basic_authorization =
      Bodyguard.permit(TimeManager.Teams, :add_user_to_team, user_assigns, user_params)

    with :ok <- basic_authorization do
      with {:ok, team} <- TeamService.get_team_by_id(team_id) do
        case TeamService.add_user_to_team(team, user_id) do
          {:ok, team} ->
            conn
            |> TeamPresenter.render_result(team, :created)

          {:error, :already_in_team} ->
            conn
            |> TeamPresenter.render_error("409.json", :conflict)

          {:error, _reason} ->
            conn
            |> TeamPresenter.render_error("500.json", :internal_server_error)
        end
      else
        _ ->
          conn
          |> TeamPresenter.render_error("404.json", :not_found)
      end
    else
      _ ->
        conn
        |> TeamPresenter.render_error("403.json", :forbidden)
    end
  end

  def delete_team(conn, %{"team_id" => team_id}) do
    user_assigns = conn.assigns[:current_user]

    basic_authorization =
      Bodyguard.permit(TimeManager.Teams, :delete_team, user_assigns, %{"team_id" => team_id})

    with :ok <- basic_authorization do
      case TeamService.delete_team(team_id) do
        {:ok, _team} ->
          conn
          |> TeamPresenter.render_result(nil, :no_content)

        {:error, _reason} ->
          conn
          |> TeamPresenter.render_error("500.json", :internal_server_error)
      end
    else
      _ ->
        conn
        |> TeamPresenter.render_error("403.json", :forbidden)
    end
  end

  def delete_user_from_team(conn, %{"team_id" => team_id, "user_id" => user_id}) do
    user_assigns = conn.assigns[:current_user]

    basic_authorization =
      Bodyguard.permit(TimeManager.Teams, :delete_user_from_team, user_assigns, %{
        "team_id" => team_id,
        "user_id" => user_id
      })

    with :ok <- basic_authorization do
      case TeamService.delete_user_from_team(team_id, user_id) do
        {:ok, team} ->
          conn
          |> TeamPresenter.render_result(team)

        {:error, _reason} ->
          conn
          |> TeamPresenter.render_error("500.json", :internal_server_error)
      end
    else
      _ ->
        conn
        |> TeamPresenter.render_error("403.json", :forbidden)
    end
  end

  def get_team_stat(conn, %{
        "team_id" => team_id,
        "start_time" => start_time,
        "end_time" => end_time
      }) do
    user_assigns = conn.assigns[:current_user]

    basic_authorization =
      Bodyguard.permit(TimeManager.Teams, :get_team_stat, user_assigns, %{
        "team_id" => team_id
      })

    with :ok <- basic_authorization do
      case TeamService.get_average_hours_by_range(team_id, start_time, end_time) do
        {:error, _reason} ->
          conn
          |> TeamPresenter.render_error("500.json", :internal_server_error)

        average ->
          conn
          |> TeamPresenter.render_result(average, :ok)
      end
    else
      _ ->
        conn
        |> TeamPresenter.render_error("403.json", :forbidden)
    end
  end

  def get_teams_of_user(conn, %{"user_id" => user_id}) do
    user_assigns = conn.assigns[:current_user]

    basic_authorization =
      Bodyguard.permit(TimeManager.Teams, :get_teams_of_user, user_assigns, %{
        "user_id" => user_id
      })

    with :ok <- basic_authorization do
      case TeamService.get_team_by_user(user_id) do
        {:ok, teams} ->
          conn
          |> TeamPresenter.render_result(teams, :ok)

        {:error, _reason} ->
          conn
          |> TeamPresenter.render_error("500.json", :internal_server_error)
      end
    else
      _ ->
        conn
        |> TeamPresenter.render_error("403.json", :forbidden)
    end
  end

  # defp render_result(conn, result) do
  #   conn
  #   |> put_status(:ok)
  #   |> put_view
  #   |> render()
  # end
end
