defmodule Nemo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :token, :string
      add :password, :string

      timestamps()
    end

  end
end
