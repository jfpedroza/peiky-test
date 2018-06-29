defmodule ApiWeb.StoreControllerTest do
  use ApiWeb.ConnCase

  alias Api.System
  alias Api.System.Store

  @create_attrs %{name: "some name", address: "some address"}
  @update_attrs %{name: "some updated name", address: "some updated address"}
  @invalid_attrs %{name: nil, address: nil}

  def fixture(:store) do
    {:ok, store} = System.create_store(@create_attrs)
    store
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all stores", %{conn: conn} do
      conn = get conn, store_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create store" do
    test "renders store when data is valid", %{conn: conn} do
      conn = post conn, store_path(conn, :create), store: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, store_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name",
        "address" => "some address"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, store_path(conn, :create), store: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update store" do
    setup [:create_store]

    test "renders store when data is valid", %{conn: conn, store: %Store{id: id} = store} do
      conn = put conn, store_path(conn, :update, store), store: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, store_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name",
        "address" => "some updated address"}
    end

    test "renders errors when data is invalid", %{conn: conn, store: store} do
      conn = put conn, store_path(conn, :update, store), store: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete store" do
    setup [:create_store]

    test "deletes chosen store", %{conn: conn, store: store} do
      conn = delete conn, store_path(conn, :delete, store)
      assert response(conn, 204)
      conn = get conn, store_path(conn, :show, store)
      assert response(conn, 404)
    end
  end

  defp create_store(_) do
    store = fixture(:store)
    {:ok, store: store}
  end
end
