defmodule Nemo.Repo.Migrations.RemoveTranslationsFromWord do
  use Ecto.Migration

  def change do
    alter table(:words) do
      remove :translated
    end
  end
end
