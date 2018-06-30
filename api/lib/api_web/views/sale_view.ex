defmodule ApiWeb.SaleView do
  use ApiWeb, :view
  alias ApiWeb.SaleView

  def render("index.json", %{sales: sales}) do
    %{data: render_many(sales, SaleView, "sale.json")}
  end

  def render("show.json", %{sale: sale}) do
    %{data: render_one(sale, SaleView, "sale.json")}
  end

  def render("sale.json", %{sale: sale}) do
    %{id: sale.id,
      price: sale.price,
      purchase_date: sale.purchase_date,
      client_name: sale.client_name,
      product_id: sale.product_id,
      store_id: sale.store_id}
  end
end
