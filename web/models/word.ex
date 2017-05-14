defmodule Nemo.Word do
  use Nemo.Web, :model

  schema "words" do
    field :word, :string
    field :translated, :string

    many_to_many :users, Nemo.User,
                 join_through: Nemo.UserWord
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:word, :translated])
    |> validate_required([:word, :translated])
  end
end
