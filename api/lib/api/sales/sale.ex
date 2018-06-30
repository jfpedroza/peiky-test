defmodule Api.Sales.Sale do
  use Ecto.Schema
  import Ecto.Changeset


  schema "sales" do
    field :client_name, :string
    field :price, :float
    field :purchase_date, :naive_datetime
    field :product_id, :id
    field :store_id, :id

    timestamps()
  end

  @doc false
  def changeset(sale, attrs) do
    sale
    |> cast(attrs, [:price, :purchase_date, :client_name, :product_id, :store_id])
    |> validate_required([:price, :purchase_date, :client_name, :product_id, :store_id])
    |> foreign_key_constraint(:product_id)
    |> foreign_key_constraint(:store_id)
  end
end
