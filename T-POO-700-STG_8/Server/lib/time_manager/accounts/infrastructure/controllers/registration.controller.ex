defmodule TimeManagerWeb.Accounts.Infrastructure.RegisterController do
  use TimeManagerWeb, :controller
  alias TimeManager.Accounts.Application.{ManageUserService}
  alias TimeManager.Accounts.Infrastructure.UserPresenter

  action_fallback TimeManagerWeb.FallbackController


  def register(conn, data) do
    with {:ok, user} <- ManageUserService.create_user(data) do
      conn |> render_result(user, :created)
    end
  end

  defp render_result(conn, result, status) do
    conn
    |> put_status(status)
    |> put_view(UserPresenter)
    |> present(result)
  end

  defp present(conn, result) do
    case is_list(result) do
      true -> render(conn, :present_users, users: result)
      false -> render(conn, :present_user, user: result)
    end
  end
end
