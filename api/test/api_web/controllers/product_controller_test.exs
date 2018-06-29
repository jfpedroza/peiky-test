defmodule ApiWeb.ProductControllerTest do
  use ApiWeb.ConnCase

  alias Api.System
  alias Api.System.Product

  require Logger

  @store_attrs %{name: "some store name", address: "some address"}
  @create_attrs %{description: "some description", name: "some name", price: 120.5, stock: 42}
  @update_attrs %{description: "some updated description", name: "some updated name", price: 456.7, stock: 43}
  @invalid_attrs %{description: nil, name: nil, price: nil, stock: nil, store_id: nil}

  def fixture(:product) do
    {:ok, store} = System.create_store(@store_attrs)
    attrs = @create_attrs
      |> Map.put(:store_id, store.id)
    {:ok, product} = System.create_product(attrs)
    product
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      store = create_store()
      conn = get conn, product_path(conn, :index, store.id)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product" do
    test "renders product when data is valid", %{conn: conn} do
      store = create_store()
      conn = post conn, product_path(conn, :create, store.id), product: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, product_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "name" => "some name",
        "price" => 120.5,
        "stock" => 42,
        "store_id" => store.id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      store = create_store()
      conn = post conn, product_path(conn, :create, store.id), product: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "returns 404 when the store is not found", %{conn: conn} do
      conn = post conn, product_path(conn, :create, 59000), product: @invalid_attrs
      assert response(conn, 404)
    end
  end

  describe "update product" do
    setup [:create_product]

    test "renders product when data is valid", %{conn: conn, product: %Product{id: id} = product} do
      conn = get conn, product_path(conn, :show, id)
      resp = json_response(conn, 200)["data"]
      %{"store_id" => store_id} = resp

      attrs = @update_attrs |> Map.put(:store_id, store_id)
      conn = put conn, product_path(conn, :update, product), product: attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, product_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "name" => "some updated name",
        "price" => 456.7,
        "stock" => 43,
        "store_id" => store_id}
    end

    test "renders errors when data is invalid", %{conn: conn, product: product} do
      conn = put conn, product_path(conn, :update, product), product: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product" do
    setup [:create_product]

    test "deletes chosen product", %{conn: conn, product: product} do
      conn = delete conn, product_path(conn, :delete, product)
      assert response(conn, 204)
      conn = get conn, product_path(conn, :show, product)
      assert response(conn, 404)
    end
  end

  defp create_product(_) do
    product = fixture(:product)
    {:ok, product: product}
  end

  defp create_store() do
    {:ok, store} = System.create_store(@store_attrs)
    store
  end
end
