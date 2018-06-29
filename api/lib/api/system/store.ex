defmodule Api.System.Store do
  use Ecto.Schema
  import Ecto.Changeset


  schema "stores" do
    field :name, :string
    field :address, :string

    timestamps()
  end

  @doc false
  def changeset(store, attrs) do
    store
    |> cast(attrs, [:name, :address])
    |> validate_required([:name, :address])
  end
end
