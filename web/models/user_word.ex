defmodule Nemo.UserWord do
  use Nemo.Web, :model

  @primary_key {:id, :id, autogenerate: true}

  schema "users_words" do
    field :uses, :integer, default: 1
    belongs_to :user, Nemo.User
    belongs_to :word, Nemo.Word

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:uses])
    |> maybe_put_assoc(params, [:user, :word])
    |> validate_required([:uses])
  end

  defp maybe_put_assoc(changeset, _params, []), do: changeset

  defp maybe_put_assoc(changeset, %{:user => user} = params, [:user | tail]) do
    changeset
    |> put_assoc(:user, user)
    |> maybe_put_assoc(params, tail)
  end

  defp maybe_put_assoc(changeset, %{:word => word} = params, [:word | tail]) do
    changeset
    |> put_assoc(:word, word)
    |> maybe_put_assoc(params, tail)
  end

  defp maybe_put_assoc(changeset, params, [_head | tail]) do
    changeset
    |> maybe_put_assoc(params, tail)
  end

end
