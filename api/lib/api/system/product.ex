defmodule Api.System.Product do
  use Ecto.Schema
  import Ecto.Changeset


  schema "products" do
    field :description, :string
    field :name, :string
    field :price, :float
    field :stock, :integer
    field :store_id, :id

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :stock, :price, :store_id])
    |> validate_required([:name, :description, :stock, :price, :store_id])
    |> foreign_key_constraint(:store_id)
  end
end
