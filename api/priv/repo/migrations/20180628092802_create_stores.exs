defmodule Api.Repo.Migrations.CreateStores do
  use Ecto.Migration

  def change do
    create table(:stores) do
      add :name, :string
      add :address, :string

      timestamps()
    end

  end
end
