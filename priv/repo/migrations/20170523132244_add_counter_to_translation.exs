defmodule Nemo.Repo.Migrations.AddCounterToTranslation do
  use Ecto.Migration

  def change do
    alter table(:users_words) do
      add :uses, :integer
    end

  end
end
