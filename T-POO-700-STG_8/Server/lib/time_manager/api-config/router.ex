defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :authenticated do
    plug TimeManagerWeb.Guard.AuthGuard
  end

  scope "/api/users", TimeManagerWeb do
    pipe_through [:api, :authenticated]

    get "/", Accounts.Infrastructure.UserController, :index
    get "/:id", Accounts.Infrastructure.UserController, :show
    post "/", Accounts.Infrastructure.UserController, :create
    put "/:id", Accounts.Infrastructure.UserController, :update
    delete "/:id", Accounts.Infrastructure.UserController, :delete
  end

  scope "/api/registration", TimeManagerWeb do
    pipe_through :api

    post "/", Accounts.Infrastructure.RegisterController, :register
  end

  scope "/api/auth", TimeManagerWeb do
    pipe_through :api

    post "/", Accounts.Infrastructure.AuthController, :login
  end

  scope "/api/auth", TimeManagerWeb do
    pipe_through [:api, :authenticated]
    get "/me", Accounts.Infrastructure.AuthController, :me
  end

  scope "/api/teams", TimeManagerWeb do
    pipe_through [:api, :authenticated]

    post "/", TimeTracking.Infrastructure.TeamsController, :create_team
    post "/:team_id/users", TimeTracking.Infrastructure.TeamsController, :add_user_to_team
    get "/", TimeTracking.Infrastructure.TeamsController, :get_teams
    get "/:team_id", TimeTracking.Infrastructure.TeamsController, :get_team

    get "/stats/:team_id", TimeTracking.Infrastructure.TeamsController, :get_team_stat

    delete "/:team_id/users/:user_id",
           TimeTracking.Infrastructure.TeamsController,
           :delete_user_from_team

    delete "/:team_id", TimeTracking.Infrastructure.TeamsController, :delete_team

    get "/user/:user_id", TimeTracking.Infrastructure.TeamsController, :get_teams_of_user

    # put "/:team_id", TimeTracking.Infrastructure.TeamsController, :update_team

    # a faire supprime user from team
  end

  scope "/api/clocks", TimeManagerWeb do
    pipe_through [:api, :authenticated]

    post "/", TimeTracking.Infrastructure.ClockController, :clock
    get "/", TimeTracking.Infrastructure.ClockController, :get_clocks
    get "/:user_id", TimeTracking.Infrastructure.ClockController, :get_clocks_by_user

    get "/week_stats/:user_id",
        TimeTracking.Infrastructure.ClockController,
        :get_week_stats

    get "/stats/daily/:user_id",
        TimeTracking.Infrastructure.ClockController,
        :get_daily_stats
  end

  scope "/api/working_times", TimeManagerWeb do
    pipe_through [:api, :authenticated]

    post "/", TimeTracking.Infrastructure.WorkingTimeController, :create_working_time
    get "/", TimeTracking.Infrastructure.WorkingTimeController, :get_working_times
    get "/:user_id", TimeTracking.Infrastructure.WorkingTimeController, :get_working_times_by_user

    get "/:user_id/:start/:end",
        TimeTracking.Infrastructure.WorkingTimeController,
        :get_working_times_by_user

    put "/:id", TimeTracking.Infrastructure.WorkingTimeController, :update_working_time

    delete "/:id", TimeTracking.Infrastructure.WorkingTimeController, :delete_working_time

    get "/stats/:user_id/:start/:end",
        TimeTracking.Infrastructure.WorkingTimeController,
        :get_working_times_by_user_by_range
  end

  # Working time 
  # On peut ajouter des heures de travails pour chaque jours pour chaque Utilisateur
  # On peut aussi faire une batch query 
  # On peut recuperer les working time d'un utilisateur
  # On peut recuperer les working time d'un utilisateur avec un start et un end
  # On peut modifier un working time
  # On peut supprimer un working time

  scope "/api/admin", TimeManagerWeb do
    pipe_through :api

    post "/:token", Accounts.Infrastructure.UserController, :admin
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:time_manager, :dev_routes) do
    scope "/swagger" do
      forward "/", PhoenixSwagger.Plug.SwaggerUI,
        otp_app: :time_manager,
        swagger_file: "swagger.json"
    end

    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard "/dashboard",
        metrics: TimeManagerWeb.Telemetry,
        ecto_repo: [TimeManager.Repo]

      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "My App"
      }
    }
  end
end
