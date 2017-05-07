defmodule Nemo.Repo.Migrations.CreateUserWord do
  use Ecto.Migration

  def change do
    create table(:users_words, primary_key: false) do

      add :user_id, references(:users)
      add :word_id, references(:words)

      timestamps()
    end

  end
end
