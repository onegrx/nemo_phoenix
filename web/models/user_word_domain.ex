defmodule Nemo.UserWord do
  use Nemo.Web, :model

  @primary_key false

  schema "users_words" do
    belongs_to :user, Nemo.User
    belongs_to :word, Nemo.Word

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
