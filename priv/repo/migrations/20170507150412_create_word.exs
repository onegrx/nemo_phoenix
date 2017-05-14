defmodule Nemo.Repo.Migrations.CreateWord do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :word, :string
      add :translated, :string

      timestamps()
    end

  end
end
