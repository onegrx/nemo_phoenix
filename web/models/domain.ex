defmodule Nemo.Domain do
  use Nemo.Web, :model

  schema "domains" do
    field :domain, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:domain])
    |> validate_required([:domain])
  end
end
