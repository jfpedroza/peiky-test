defmodule Api.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :string
      add :stock, :integer
      add :price, :float
      add :store_id, references(:stores, on_delete: :delete_all)

      timestamps()
    end

    create index(:products, [:store_id])
  end
end
