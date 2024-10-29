defmodule TimeManager.Repo do
  use Ecto.Repo,
    otp_app: :time_manager,
    adapter: Ecto.Adapters.Postgres

  # defmacro is_uuid(value) do
  #   quote do
  #     is_binary(unquote(value)) and byte_size(unquote(value)) == 36 and
  #       binary_part(unquote(value), 8, 1) == "-" and binary_part(unquote(value), 13, 1) == "-" and
  #       binary_part(unquote(value), 18, 1) == "-" and binary_part(unquote(value), 23, 1) == "-"
  #   end
  # end

  def is_uuid(value) do
    is_binary(value) and byte_size(value) == 36 and
      binary_part(value, 8, 1) == "-" and binary_part(value, 13, 1) == "-" and
      binary_part(value, 18, 1) == "-" and binary_part(value, 23, 1) == "-"
  end
end
