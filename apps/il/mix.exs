defmodule Il.Mixfile do
  use Mix.Project

  @version "0.5.134"

  def project do
    [
      app: :il,
      description: "Add description to your package.",
      package: package(),
      version: @version,
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test],
      docs: [source_ref: "v#\{@version\}", main: "readme", extras: ["README.md"]]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      extra_applications: [:logger, :runtime_tools],
      mod: {Il, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:distillery, "~> 1.4.1"},
      {:confex, "~> 3.2"},
      {:timex, ">= 3.1.15"},
      {:logger_json, "~> 0.5.0"},
      {:poison, "~> 3.1"},
      {:plug, "~> 1.4"},
      {:cowboy, "~> 1.1"},
      {:httpoison, "~> 0.12"},
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 2.1"},
      {:scrivener_ecto, "~> 1.2"},
      {:ecto_trail, "~> 0.2.3"},
      {:phoenix, "~> 1.3.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:eview, "~> 0.12.2"},
      {:jvalid, "~> 0.6.0"},
      {:bamboo, "~> 0.8"},
      {:bamboo_postmark, "~> 0.2.0"},
      {:geo, "~> 1.4"},
      {:quantum, ">= 2.1.0"},
      {:benchfella, ">= 0.3.4", only: [:dev, :test]},
      {:ex_doc, ">= 0.15.0", only: [:dev, :test]},
      {:excoveralls, ">= 0.5.0", only: [:dev, :test]},
      {:ex_machina, "~> 2.0", only: [:dev, :test]},
      {:dogma, ">= 0.1.12", only: [:dev, :test]},
      {:credo, ">= 0.5.1", only: [:dev, :test]}
    ]
  end

  # Settings for publishing in Hex package manager:
  defp package do
    [contributors: ["Nebo #15"],
     maintainers: ["Nebo #15"],
     licenses: ["LISENSE.md"],
     links: %{github: "https://github.com/Nebo15/ehealth"},
     files: ~w(lib LICENSE.md mix.exs README.md)]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": [
        "ecto.create",
        "ecto.create --repo Il.PRMRepo",
        "ecto.migrate",
        "run priv/repo/seeds.exs"
      ],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": [
        "ecto.create --quiet",
        "ecto.create --quiet --repo Il.PRMRepo",
        "ecto.migrate",
        "test"
      ]
    ]
  end
end
