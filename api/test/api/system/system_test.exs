defmodule Api.SystemTest do
  use Api.DataCase

  alias Api.System

  describe "stores" do
    alias Api.System.Store

    @valid_attrs %{name: "some name", address: "some address"}
    @update_attrs %{name: "some updated name", address: "some updated address"}
    @invalid_attrs %{name: nil, address: nil}

    def store_fixture(attrs \\ %{}) do
      {:ok, store} =
        attrs
        |> Enum.into(@valid_attrs)
        |> System.create_store()

      store
    end

    test "list_stores/0 returns all stores" do
      store = store_fixture()
      assert System.list_stores() == [store]
    end

    test "get_store/1 returns the store with given id" do
      store = store_fixture()
      assert System.get_store(store.id) == store
    end

    test "create_store/1 with valid data creates a store" do
      assert {:ok, %Store{} = store} = System.create_store(@valid_attrs)
      assert store.name == "some name"
      assert store.address == "some address"
    end

    test "create_store/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = System.create_store(@invalid_attrs)
    end

    test "update_store/2 with valid data updates the store" do
      store = store_fixture()
      assert {:ok, store} = System.update_store(store, @update_attrs)
      assert %Store{} = store
      assert store.name == "some updated name"
      assert store.address == "some updated address"
    end

    test "update_store/2 with invalid data returns error changeset" do
      store = store_fixture()
      assert {:error, %Ecto.Changeset{}} = System.update_store(store, @invalid_attrs)
      assert store == System.get_store(store.id)
    end

    test "delete_store/1 deletes the store" do
      store = store_fixture()
      assert {:ok, %Store{}} = System.delete_store(store)
      assert nil == System.get_store(store.id)
    end

    test "change_store/1 returns a store changeset" do
      store = store_fixture()
      assert %Ecto.Changeset{} = System.change_store(store)
    end
  end

  describe "products" do
    alias Api.System.Product

    @store_attrs %{name: "some store name", address: "some address"}
    @valid_attrs %{description: "some description", name: "some name", price: 120.5, stock: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", price: 456.7, stock: 43}
    @invalid_attrs %{description: nil, name: nil, price: nil, stock: nil, store_id: nil}

    def product_fixture(store, attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Map.put(:store_id, store.id)
        |> Enum.into(@valid_attrs)
        |> System.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture(store_fixture())
      assert System.list_products() == [product]
    end

    test "list_products/1 returns all products of a store" do
      store = store_fixture()
      product = product_fixture(store)
      assert System.list_products(store.id) == [product]
    end

    test "get_product/1 returns the product with given id" do
      product = product_fixture(store_fixture())
      assert System.get_product(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      store = store_fixture()
      attrs = @valid_attrs |> Map.put(:store_id, store.id)
      assert {:ok, %Product{} = product} = System.create_product(attrs)
      assert product.description == "some description"
      assert product.name == "some name"
      assert product.price == 120.5
      assert product.stock == 42
      assert product.store_id == store.id
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = System.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      store = store_fixture()
      product = product_fixture(store)
      attrs = @update_attrs |> Map.put(:store_id, store.id)
      assert {:ok, product} = System.update_product(product, attrs)
      assert %Product{} = product
      assert product.description == "some updated description"
      assert product.name == "some updated name"
      assert product.price == 456.7
      assert product.stock == 43
      assert product.store_id == store.id
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture(store_fixture())
      assert {:error, %Ecto.Changeset{}} = System.update_product(product, @invalid_attrs)
      assert product == System.get_product(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture(store_fixture())
      assert {:ok, %Product{}} = System.delete_product(product)
      assert nil == System.get_product(product.id)
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture(store_fixture())
      assert %Ecto.Changeset{} = System.change_product(product)
    end
  end
end
