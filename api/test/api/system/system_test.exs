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

    test "get_store!/1 returns the store with given id" do
      store = store_fixture()
      assert System.get_store!(store.id) == store
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
      assert store == System.get_store!(store.id)
    end

    test "delete_store/1 deletes the store" do
      store = store_fixture()
      assert {:ok, %Store{}} = System.delete_store(store)
      assert_raise Ecto.NoResultsError, fn -> System.get_store!(store.id) end
    end

    test "change_store/1 returns a store changeset" do
      store = store_fixture()
      assert %Ecto.Changeset{} = System.change_store(store)
    end
  end
end
