defmodule Nemo.User do
  use Nemo.Web, :model

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
  end

end
