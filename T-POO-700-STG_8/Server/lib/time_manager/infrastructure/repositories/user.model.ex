defmodule TimeManager.Accounts.UserModel do
  use TimeManager, :domain_model

  alias TimeManager.Accounts.Application.PasswordHasher
  alias TimeManager.Accounts.UserModel
  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :username, :string
    field :email, :string
    field :password_hash, :string
    field :role, Ecto.Enum, values: [:admin, :manager, :user], default: :user
    # field :manager_id, :binary_id

    belongs_to(:manager, UserModel)
    field :password, :string, virtual: true

    timestamps(type: :utc_datetime)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :role, :manager_id])
    |> validate_required([:username, :email, :password])
    |> validate_length(:username, min: 3, max: 30)
    |> validate_length(:password, min: 8, max: 100)
    |> validate_format(:email, ~r/@/)
    |> hash_password()
    |> unique_constraint(:email)
  end

  def changeset_update(user, attrs) do
    user
        |> cast(attrs, [:username, :email, :password, :role, :manager_id])
        |> validate_length(:username, min: 3, max: 30)
        |> validate_length(:password, min: 8, max: 100)
        |> validate_format(:email, ~r/@/)
        |> hash_password()
        |> unique_constraint(:email)
  end

  defp hash_password(changeset) do
    if changeset.valid? do
      case get_change(changeset, :password) do
        nil -> changeset
        password -> put_change(changeset, :password_hash, PasswordHasher.hash(password))
      end
    else
      changeset
    end
  end
end
