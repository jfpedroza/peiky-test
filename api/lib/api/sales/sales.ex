defmodule Api.Sales do
  @moduledoc """
  The Sales context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Sales.Sale

  @doc """
  Returns the list of sales.

  ## Examples

      iex> list_sales()
      [%Sale{}, ...]

  """
  def list_sales do
    Repo.all(Sale)
  end

  @doc """
  Returns the list of sales by store.

  ## Examples

      iex> list_sales(store_id)
      [%Sale{}, ...]

  """
  def list_sales(store_id) do
    Sale
    |> where(store_id: ^store_id)
    |> Repo.all
  end

  @doc """
  Returns the list of sales by product.

  ## Examples

      iex> list_sales_per_product(product_id)
      [%Sale{}, ...]

  """
  def list_sales_per_product(product_id) do
    Sale
    |> where(product_id: ^product_id)
    |> Repo.all
  end

  @doc """
  Gets a single sale.

  Returns `nil` if the Sale does not exist.

  ## Examples

      iex> get_sale(123)
      %Sale{}

      iex> get_sale(456)
      nil

  """
  def get_sale(id), do: Repo.get(Sale, id)

  @doc """
  Creates a sale.

  ## Examples

      iex> create_sale(%{field: value})
      {:ok, %Sale{}}

      iex> create_sale(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sale(attrs \\ %{}) do
    %Sale{}
    |> Sale.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sale.

  ## Examples

      iex> update_sale(sale, %{field: new_value})
      {:ok, %Sale{}}

      iex> update_sale(sale, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sale(%Sale{} = sale, attrs) do
    sale
    |> Sale.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Sale.

  ## Examples

      iex> delete_sale(sale)
      {:ok, %Sale{}}

      iex> delete_sale(sale)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sale(%Sale{} = sale) do
    Repo.delete(sale)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sale changes.

  ## Examples

      iex> change_sale(sale)
      %Ecto.Changeset{source: %Sale{}}

  """
  def change_sale(%Sale{} = sale) do
    Sale.changeset(sale, %{})
  end
end
