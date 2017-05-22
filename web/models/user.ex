defmodule Nemo.User do
  use Nemo.Web, :model
  import Ecto.Changeset

  schema "users" do
    field :email, :string, unique: true
    field :username, :string, unique: true
    field :token, :string
    field :password, :string

    timestamps()

    many_to_many :words, Nemo.Word,
                 join_through: Nemo.UserWord

  end

  @required_fields [:email, :password, :username]

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password, :username, :token])
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> hash_password
    |> generate_unique_token
  end

  defp hash_password(changeset) do
    %{changeset | password: Comeonin.Bcrypt.hashpwsalt(changeset.password)}
  end

  defp generate_unique_token(changeset, length \\ 7) do
    token = :crypto.strong_rand_bytes(length)
      |> Base.url_encode64
      |> binary_part(0, length)
    %{changeset | token: changeset.username <> "-" <> token}
  end

end
