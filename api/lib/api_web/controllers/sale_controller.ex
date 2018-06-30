defmodule ApiWeb.SaleController do
  use ApiWeb, :controller

  alias Api.Sales
  alias Api.Sales.Sale
  alias Api.System

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    sales = Sales.list_sales()
    render(conn, "index.json", sales: sales)
  end

  def per_store(conn, %{"store_id" => store_id}) do
    store = System.get_store(store_id)
    if store do
      sales = Sales.list_sales(store_id)
      render(conn, "index.json", sales: sales)
    else
      conn
      |> put_status(:not_found)
      |> render("index.json", sales: [])
    end
  end

  def per_product(conn, %{"product_id" => product_id}) do
    product = System.get_product(product_id)
    if product do
      sales = Sales.list_sales_per_product(product_id)
      render(conn, "index.json", sales: sales)
    else
      conn
      |> put_status(:not_found)
      |> render("index.json", sales: [])
    end
  end

  def create(conn, %{"store_id" => store_id, "sale" => sale_params}) do
    store = System.get_store(store_id)
    if store do
      product_id = sale_params["product_id"]
      product = if product_id, do: System.get_product(product_id), else: nil
      if product || product_id == nil do
        sale_params = Map.put(sale_params, "store_id", store_id)
        with {:ok, %Sale{} = sale} <- Sales.create_sale(sale_params) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", sale_path(conn, :show, sale))
          |> render("show.json", sale: sale)
        end
      else
        conn
        |> put_status(:not_found)
        |> render("show.json", sale: nil)
      end
    else
      conn
      |> put_status(:not_found)
      |> render("show.json", sale: nil)
    end
  end

  def show(conn, %{"id" => id}) do
    sale = Sales.get_sale(id)

    if sale do
      render(conn, "show.json", sale: sale)
    else
      conn
      |> put_status(:not_found)
      |> render("show.json", sale: sale)
    end
  end

  def update(conn, %{"id" => id, "sale" => sale_params}) do
    sale = Sales.get_sale(id)

    if sale do
      with {:ok, %Sale{} = sale} <- Sales.update_sale(sale, sale_params) do
        render(conn, "show.json", sale: sale)
      end
    else
      conn
      |> put_status(:not_found)
      |> render("show.json", sale: sale)
    end
  end

  def delete(conn, %{"id" => id}) do
    sale = Sales.get_sale(id)

    if sale do
      with {:ok, %Sale{}} <- Sales.delete_sale(sale) do
        send_resp(conn, :no_content, "")
      end
    else
      conn
      |> put_status(:not_found)
      |> render("show.json", sale: sale)
    end
  end
end
