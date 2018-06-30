defmodule Api.SalesTest do
  use Api.DataCase

  alias Api.Sales
  alias Api.System

  describe "sales" do
    alias Api.Sales.Sale

    @store_attrs %{name: "some store name", address: "some address"}
    @product_attrs %{description: "some description", name: "some name", price: 120.5, stock: 42}
    @valid_attrs %{client_name: "some client_name", price: 120.5, purchase_date: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{client_name: "some updated client_name", price: 456.7, purchase_date: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{client_name: nil, price: nil, purchase_date: nil, product_id: nil, store_id: nil}

    def store_fixture(attrs \\ %{}) do
      {:ok, store} =
        attrs
        |> Enum.into(@store_attrs)
        |> System.create_store()

      store
    end

    def product_fixture(store, attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Map.put(:store_id, store.id)
        |> Enum.into(@product_attrs)
        |> System.create_product()

      product
    end

    def sale_fixture(product, attrs \\ %{}) do
      {:ok, sale} =
        attrs
        |> Map.put(:product_id, product.id)
        |> Map.put(:store_id, product.store_id)
        |> Enum.into(@valid_attrs)
        |> Sales.create_sale()

      sale
    end

    def sale_fixture() do
      %{}
      |> store_fixture()
      |> product_fixture()
      |> sale_fixture()
    end

    test "list_sales/0 returns all sales" do
      sale = sale_fixture()
      assert Sales.list_sales() == [sale]
    end

    test "list_sales/1 returns all sales of a store" do
      sale = sale_fixture()
      assert Sales.list_sales(sale.store_id) == [sale]
    end

    test "list_sales_per_product/1 returns all sales of a product" do
      sale = sale_fixture()
      assert Sales.list_sales_per_product(sale.product_id) == [sale]
    end

    test "get_sale!/1 returns the sale with given id" do
      sale = sale_fixture()
      assert Sales.get_sale(sale.id) == sale
    end

    test "create_sale/1 with valid data creates a sale" do
      product = store_fixture() |> product_fixture
      attrs = @valid_attrs
        |> Map.put(:store_id, product.store_id)
        |> Map.put(:product_id, product.id)
      assert {:ok, %Sale{} = sale} = Sales.create_sale(attrs)
      assert sale.client_name == "some client_name"
      assert sale.price == 120.5
      assert sale.purchase_date == ~N[2010-04-17 14:00:00.000000]
      assert sale.product_id == product.id
      assert sale.store_id == product.store_id
    end

    test "create_sale/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sales.create_sale(@invalid_attrs)
    end

    test "update_sale/2 with valid data updates the sale" do
      sale = sale_fixture()
      attrs = @update_attrs
        |> Map.put(:store_id, sale.store_id)
        |> Map.put(:product_id, sale.product_id)
      assert {:ok, sale} = Sales.update_sale(sale, attrs)
      assert %Sale{} = sale
      assert sale.client_name == "some updated client_name"
      assert sale.price == 456.7
      assert sale.purchase_date == ~N[2011-05-18 15:01:01.000000]
      assert sale.product_id == sale.product_id
      assert sale.store_id == sale.store_id
    end

    test "update_sale/2 with invalid data returns error changeset" do
      sale = sale_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.update_sale(sale, @invalid_attrs)
      assert sale == Sales.get_sale(sale.id)
    end

    test "delete_sale/1 deletes the sale" do
      sale = sale_fixture()
      assert {:ok, %Sale{}} = Sales.delete_sale(sale)
      assert nil == Sales.get_sale(sale.id)
    end

    test "change_sale/1 returns a sale changeset" do
      sale = sale_fixture()
      assert %Ecto.Changeset{} = Sales.change_sale(sale)
    end
  end
end
