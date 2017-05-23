defmodule Nemo.User do
  use Nemo.Web, :model
  import Ecto.Changeset

  schema "users" do
    field :email, :string, unique: true
    field :username, :string, unique: true
    field :token, :string
    field :password, Nemo.User.PasswordType

    timestamps()

    many_to_many :words, Nemo.Word,
                 join_through: Nemo.UserWord
  end

  @token_suffix_length 7

  @required_fields [:email, :password, :username]

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> put_token()
  end

  def put_token(changeset) do
    case get_field(changeset, :username) do
      nil -> changeset
      username -> put_change(changeset, :token, get_token(username))
    end
  end

  defp get_token(username) do
    token = :crypto.strong_rand_bytes(@token_suffix_length)
            |> Base.url_encode64
            |> binary_part(0, @token_suffix_length)
    username <> "-" <> token
  end

end
