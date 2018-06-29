defmodule ApiWeb.ProductController do
  use ApiWeb, :controller

  alias Api.System
  alias Api.System.Product

  require Logger

  action_fallback ApiWeb.FallbackController

  def index(conn, %{"store_id" => store_id}) do
    store = System.get_store(store_id)
    if store do
      products = System.list_products(store_id)
      render(conn, "index.json", products: products)
    else
      conn
      |> put_status(:not_found)
      |> render("index.json", products: [])
    end
  end

  def create(conn, %{"store_id" => store_id, "product" => product_params}) do
    store = System.get_store(store_id)
    if store do
      product_params = Map.put(product_params, "store_id", store_id)
      with {:ok, %Product{} = product} <- System.create_product(product_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", product_path(conn, :show, product))
        |> render("show.json", product: product)
      end
    else
      conn
      |> put_status(:not_found)
      |> render("show.json", product: nil)
    end
  end

  def show(conn, %{"id" => id}) do
    product = System.get_product(id)

    if product do
      render(conn, "show.json", product: product)
    else
      conn
      |> put_status(:not_found)
      |> render("show.json", product: product)
    end
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = System.get_product(id)

    if product do
      with {:ok, %Product{} = product} <- System.update_product(product, product_params) do
        render(conn, "show.json", product: product)
      end
    else
      conn
      |> put_status(:not_found)
      |> render("show.json", product: product)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = System.get_product(id)

    if product do
      with {:ok, %Product{}} <- System.delete_product(product) do
        send_resp(conn, :no_content, "")
      end
    else
      conn
      |> put_status(:not_found)
      |> render("show.json", product: product)
    end
  end
end
