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
<<<<<<< HEAD
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
=======
    |> cast(params, [:id, :email, :token, :crypted_password, :password])
    # |> validate_required([:id, :email, :crypted_password]) TODO fix
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
>>>>>>> dd16a08... Register user with email and password
  end

end
