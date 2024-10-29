import Config

config :time_manager, TimeManagerWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {0, 0, 0, 0}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  watchers: []


config :bcrypt_elixir, log_rounds: 12

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: TimeManager.Finch


config :time_manager,
       TimeManager.Accounts.Application.UserRepository,
       TimeManager.Accounts.Infrastructure.UserRepository

config :time_manager,
       TimeManager.TimeTracking.Application.TeamRepository,
       TimeManager.TimeTracking.Infrastructure.TeamRepository

config :time_manager,
       TimeManager.TimeTracking.Application.ClockRepository,
       TimeManager.TimeTracking.Infrastructure.ClockRepository

config :time_manager,
       TimeManager.TimeTracking.Application.WorkingTimeRepository,
       TimeManager.TimeTracking.Infrastructure.WorkingTimeRepository

config :time_manager,
       :date_provider,
       TimeManager.TimeTracking.Infrastructure.DateProvider
