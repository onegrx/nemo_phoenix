defmodule Nemo.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :email, :string
      add :token, :string
    end

  end
end
