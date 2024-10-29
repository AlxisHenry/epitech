defmodule TimeManagerWeb.Accounts.Infrastructure.AuthController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts.{Infrastructure.UserPresenter, Application.AuthService}

  action_fallback(TimeManagerWeb.FallbackController)



  def login(conn, data) do
    with {:ok, user} <- AuthService.login(data) do
      conn |> render_result(user, :ok)
    else
      {:error, :invalid_password} ->
        conn |> render_error("401.json", :unauthorized)

      {:error, :user_not_found} ->
        conn |> render_error("404.json", :not_found)
    end
  end

  def me(conn, _params) do
    conn
    |> render_result(conn.assigns.current_user, :ok)
  end

  defp render_result(conn, result, status) do
    conn
    |> put_status(status)
    |> put_view(UserPresenter)
    |> render(:present_auth_user, user: result)
  end

  defp render_error(conn, template, status) do
    conn
    |> put_status(status)
    |> put_view(TimeManagerWeb.ErrorView)
    |> render(template)
  end
end
