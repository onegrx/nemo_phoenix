defmodule Nemo.Translation do
  use Nemo.Web, :model
  import Ecto.Changeset

  schema "translations" do
    field :translation, :string, unique: true
    belongs_to :users_words, Nemo.UserWord
    timestamps()
  end

end
