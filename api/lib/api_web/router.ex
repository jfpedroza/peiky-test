defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ApiWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", ApiWeb do
    pipe_through :api

    get "/stores", StoreController, :index
    get "/stores/:id", StoreController, :show
    post "/stores", StoreController, :create
    put "/stores/:id", StoreController, :update
    delete "/stores/:id", StoreController, :delete

    get "/stores/:store_id/products", ProductController, :index
    get "/products/:id", ProductController, :show
    post "/stores/:store_id/products", ProductController, :create
    put "/products/:id", ProductController, :update
    delete "/products/:id", ProductController, :delete
  end
end
