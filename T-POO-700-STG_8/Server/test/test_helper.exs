ExUnit.start()

ExUnit.configure(seed: 0, trace: true)

Ecto.Adapters.SQL.Sandbox.mode(TimeManager.Repo, :manual)
