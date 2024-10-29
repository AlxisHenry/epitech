# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TimeManagerBackend.Repo.insert!(%TimeManagerBackend.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TimeManager.{ManageUserService}
alias TimeManager.TimeTracking.Application.{ManageClockService, ManageWorkingTimeService}

# Insert users
{:ok, user1} = ManageUserService.create_user(%{
  username: "test",
  email: "test@test.com"
})

{:ok, user2} = ManageUserService.create_user(%{
  username: "test2",
  email: "test2@test2.com"
})

{:ok, user3} = ManageUserService.create_user(%{
  username: "test3",
  email: "test3@test3.com"
})

# Insert clock 
ManageClockService.create_clock(%{
  "userID" => user1.id,
  "clock" => %{
    "status" => true,
    "time" => ~N[2024-10-09 08:00:00]
  }
})

ManageClockService.create_clock(%{
  "userID" => user2.id,
  "clock" => %{
    "status" => false,
    "time" => ~N[2024-10-09 17:00:00]
  }
})

ManageClockService.create_clock(%{
  "userID" => user3.id,
  "clock" => %{
    "status" => false,
    "time" => ~N[2024-10-09 17:00:00]
  }
})

# Insert working time 
ManageWorkingTimeService.create_working_time(%{
  "userID" => user1.id,
  "working_time" => %{
    "end" => ~N[2024-10-09 17:00:00],
    "start" => ~N[2024-10-09 09:00:00]    
  }
})

ManageWorkingTimeService.create_working_time(%{
  "userID" => user2.id,
  "working_time" => %{
    "end" => ~N[2024-10-09 17:00:00],
    "start" => ~N[2024-10-09 09:00:00]
  }
})

ManageWorkingTimeService.create_working_time(%{
  "userID" => user3.id,
  "working_time" => %{
    "end" => ~N[2024-10-09 17:00:00],  
    "start" => ~N[2024-10-09 09:00:00]
  }
})