defmodule Api.Repo.Migrations.CreateSales do
  use Ecto.Migration

  def change do
    create table(:sales) do
      add :price, :float
      add :purchase_date, :naive_datetime
      add :client_name, :string
      add :product_id, references(:products, on_delete: :nothing)
      add :store_id, references(:stores, on_delete: :nothing)

      timestamps()
    end

    create index(:sales, [:product_id])
    create index(:sales, [:store_id])
  end
end
