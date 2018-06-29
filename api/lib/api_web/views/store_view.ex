defmodule ApiWeb.StoreView do
  use ApiWeb, :view
  alias ApiWeb.StoreView

  def render("index.json", %{stores: stores}) do
    %{data: render_many(stores, StoreView, "store.json")}
  end

  def render("show.json", %{store: store}) do
    %{data: render_one(store, StoreView, "store.json")}
  end

  def render("store.json", %{store: store}) do
    %{id: store.id,
      name: store.name,
      address: store.address}
  end
end
