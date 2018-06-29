# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Api.Repo.insert!(%Api.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Api.Repo.insert!(%Api.System.Store{name: "Store #1", address: "Address #1"})
Api.Repo.insert!(%Api.System.Store{name: "Store #2", address: "Address #2"})
Api.Repo.insert!(%Api.System.Product{name: "Product #1", description: "Description of product #1", price: 1500.0, stock: 50, store_id: 1})
Api.Repo.insert!(%Api.System.Product{name: "Product #2", description: "Description of product #2", price: 8300.0, stock: 20, store_id: 1})
Api.Repo.insert!(%Api.System.Product{name: "Product #3", description: "Description of product #3", price: 350.0, stock: 36, store_id: 2})
