defmodule TimeManager.Accounts.Authorization do
  @behaviour Bodyguard.Policy
  # def authorize(_, %Accounts.UserModel{id: user_id}, _), do: :ok
  def authorize(:update_user, %{id: user_id} = _id_from_token, %{id: user_id} = _id_from_param),
    do: :ok

  def authorize(:update_user, %{role: :admin}, _), do: :ok
  def authorize(:get_users, %{role: role}, _) when role in [:admin, :manager], do: :ok
  def authorize(:get_user, %{role: :admin}, _), do: :ok
  def authorize(:get_user, %{role: :manager}, _), do: :ok

  def authorize(:create_user, %{role: :admin}, _), do: :ok
  def authorize(:delete_user, %{role: :admin}, _), do: :ok
  def authorize(:delete_user, %{id: user_id}, %{id: user_id}), do: :ok

  def authorize(_, _, _), do: false

  def permission(:update_user, %{role: :admin}, _), do: :ok

  def permission(:update_user, %{role: role} = _user, update_params)
      when map_size(update_params) > 0 and role in [:user, :manager] do
    restricted_fields = ["role", "manager_id"]

    case Enum.any?(restricted_fields, &Map.has_key?(update_params, &1)) do
      true -> :none
      false -> :ok
    end
  end

  def permission(:get_users, %{role: :admin}), do: :full
  def permission(:get_users, %{role: :manager}), do: :partial
  def permission(:get_users, %{role: :user}), do: :none

  def permission(:get_user, %{role: :admin}, _), do: :full
  def permission(:get_user, %{id: user_id, role: :manager}, %{manager: user_id}), do: :full
  def permission(:get_user, %{role: :manager}, _), do: :none
  def permission(:get_user, %{id: user_id, role: :user}, %{id: user_id}), do: :full
  def permission(:get_user, %{role: :user}, _), do: :none

  def permission(_, _), do: :none
end

defmodule TimeManager.Accounts do
  defdelegate authorize(action, user, params), to: TimeManager.Accounts.Authorization
end
