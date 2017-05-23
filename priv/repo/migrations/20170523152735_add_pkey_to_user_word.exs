defmodule Nemo.Repo.Migrations.AddPkeyToUserWord do
  use Ecto.Migration

  def change do
    alter table(:users_words) do
      add :id, :serial, primary_key: true
    end

    create unique_index(:users_words, [:id])
  end
end
