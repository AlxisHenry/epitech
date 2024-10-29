defmodule UUIDValidator do
  def valide_uuid(id) do
    case Ecto.UUID.cast(id) do
      :error -> {:error, "is not a valid UUID"}
      {:ok, valide_id} -> {:ok, valide_id}
    end
  end

  def dump_uuid(id) do
    try do
      valid = Ecto.UUID.dump!(id)
      {:ok, valid}
    rescue
      _error -> {:error, "is not a valid UUID"}
    end
  end
end
