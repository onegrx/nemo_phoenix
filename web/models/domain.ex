defmodule Nemo.Domain do
  use Nemo.Web, :model
  import Ecto.Changeset

  schema "domains" do
    field :domain, :string
    belongs_to :users_words, Nemo.UserWord
    timestamps()
  end

end
