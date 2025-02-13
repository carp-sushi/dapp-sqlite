defmodule Dapp.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :text, null: false
    end
    create unique_index(:roles, [:name])
  end
end
