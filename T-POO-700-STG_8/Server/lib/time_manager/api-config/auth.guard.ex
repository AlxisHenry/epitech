defmodule TimeManagerWeb.Guard.AuthGuard do
  import Plug.Conn
  alias TimeManager.Accounts.Application.AuthService

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user} <- AuthService.auth_with_token(token) do
      conn |> assign(:current_user, user)
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(TimeManagerWeb.ErrorView)
        |> Phoenix.Controller.render("401.json")
        |> halt()
    end
  end
end
