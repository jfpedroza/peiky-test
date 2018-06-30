defmodule ApiWeb.SaleControllerTest do
  use ApiWeb.ConnCase

  alias Api.Sales
  alias Api.Sales.Sale
  alias Api.System

  require Logger

  @store_attrs %{name: "some store name", address: "some address"}
  @product_attrs %{description: "some description", name: "some name", price: 120.5, stock: 42}
  @create_attrs %{client_name: "some client_name", price: 120.5, purchase_date: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{client_name: "some updated client_name", price: 456.7, purchase_date: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{client_name: nil, price: nil, purchase_date: nil}

  def fixture(:product) do
    {:ok, store} = System.create_store(@store_attrs)
    attrs = @product_attrs
      |> Map.put(:store_id, store.id)
    {:ok, product} = System.create_product(attrs)
    product
  end

  def fixture(:sale) do
    product = fixture(:product)
    attrs = @create_attrs
      |> Map.put(:product_id, product.id)
      |> Map.put(:store_id, product.store_id)

    {:ok, sale} = Sales.create_sale(attrs)
    sale
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sales", %{conn: conn} do
      conn = get conn, sale_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "per store" do
    test "lists all sales of a store", %{conn: conn} do
      store = create_store()
      conn = get conn, sale_path(conn, :per_store, store.id)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "per product" do
    test "lists all sales of a product", %{conn: conn} do
      product = create_product()
      conn = get conn, sale_path(conn, :per_product, product.id)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create sale" do
    test "renders sale when data is valid", %{conn: conn} do
      product = create_product()
      attrs = @create_attrs |> Map.put(:product_id, product.id)
      conn = post conn, sale_path(conn, :create, product.store_id), sale: attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, sale_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "client_name" => "some client_name",
        "price" => 120.5,
        "purchase_date" => "2010-04-17T14:00:00.000000",
        "product_id" => product.id,
        "store_id" => product.store_id}

    end

    test "renders errors when data is invalid", %{conn: conn} do
      product = create_product()
      conn = post conn, sale_path(conn, :create, product.store_id), sale: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "returns 404 when the store is not found", %{conn: conn} do
      conn = post conn, sale_path(conn, :create, 59000), sale: @invalid_attrs
      assert response(conn, 404)
    end
  end

  describe "update sale" do
    setup [:create_sale]

    test "renders sale when data is valid", %{conn: conn, sale: %Sale{id: id} = sale} do
      conn = get conn, sale_path(conn, :show, id)
      resp = json_response(conn, 200)["data"]
      %{"store_id" => store_id, "product_id" => product_id} = resp

      attrs = @update_attrs
      |> Map.put(:product_id, product_id)
      |> Map.put(:store_id, store_id)
      conn = put conn, sale_path(conn, :update, sale), sale: attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, sale_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "client_name" => "some updated client_name",
        "price" => 456.7,
        "purchase_date" => "2011-05-18T15:01:01.000000",
        "store_id" => store_id,
        "product_id" => product_id}
    end

    test "renders errors when data is invalid", %{conn: conn, sale: sale} do
      conn = put conn, sale_path(conn, :update, sale), sale: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete sale" do
    setup [:create_sale]

    test "deletes chosen sale", %{conn: conn, sale: sale} do
      conn = delete conn, sale_path(conn, :delete, sale)
      assert response(conn, 204)
      conn = get conn, sale_path(conn, :show, sale)
      assert response(conn, 404)
    end
  end

  defp create_sale(_) do
    sale = fixture(:sale)
    {:ok, sale: sale}
  end

  defp create_product() do
    fixture(:product)
  end

  defp create_store() do
    {:ok, store} = System.create_store(@store_attrs)
    store
  end
end
