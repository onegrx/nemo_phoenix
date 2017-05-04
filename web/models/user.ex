defmodule Nemo.User do
  use Nemo.Web, :model

  @required_fields ~w(email password)

  schema "users" do
    field :email, :string
    field :token, :string
    field :password, :string
    field :username, :string

    timestamps()

    many_to_many :words, Nemo.Word,
                 join_through: Nemo.UserWord

  end

  @required_fields [:email, :token, :password, :username]

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
  end

end
