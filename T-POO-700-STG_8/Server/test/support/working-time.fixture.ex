defmodule TimeManager.Test.WorkingTimesFixture do
  use TimeManagerWeb.ConnCase
  alias TimeManager.TimeTracking.Application.WorkingTimeService

  def given_existing_wt(working_times) do
    Enum.map(working_times, fn wt ->
      {:ok, wt} = WorkingTimeService.create_wt(wt)
      wt
    end)
  end

  def when_getting_wt(conn) do
    conn
    |> get("/api/working_times")
  end

  def then_wt_should_be_returned(conn, wts) do
    response_body = Poison.decode!(conn.resp_body)

    assert conn.status == 200

    Enum.each(wts, fn wt ->
      assert Enum.any?(response_body["data"], fn wt_response ->
               wt_response["user_id"] == wt.user_id
             end)
    end)
  end
end
