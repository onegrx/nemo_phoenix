defmodule Nemo.Repo.Migrations.RenameCounter do
  use Ecto.Migration

  def change do
    rename table(:users_words), :uses, to: :seek_counter
  end
end
