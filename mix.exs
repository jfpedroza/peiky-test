defmodule PeikyTest.Mixfile do
  use Mix.Project

  def project do
    [
      apps_path: ".",
      apps: [:api],
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      elixir: "~> 1.4",
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp deps do
    []
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run api/priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"]
    ]
  end

end
