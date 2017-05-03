defmodule Nemo.Repo.Migrations.AddCryptedPassword do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :crypted_password, :string
    end
    
  end
end
