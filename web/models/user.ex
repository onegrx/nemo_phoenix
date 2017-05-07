defmodule Nemo.User do
  use Nemo.Web, :model

  schema "users" do
    field :email, :string
    field :token, :string
    field :password, :string

    many_to_many :words, Nemo.Word,
                 join_through: Nemo.UserWord

    timestamps()
  end

  @required_fields [:email, :token, :password]

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
