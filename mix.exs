defmodule Glossolalia.Mixfile do
  use Mix.Project

  def project do
    [app: :glossolalia,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps,
     services: services,
     translations: translations,
     servicetypes: servicetypes
   ]
  end


  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Glossolalia, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.1.4"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_ecto, "~> 2.0"},
     {:phoenix_html, "~> 2.4"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:ex_hl7, "~> 0.1.3"},
     {:httpoison, "~> 0.6"},
     {:gettext, "~> 0.9"},
     {:cowboy, "~> 1.0"},
     {:sqlite_ecto, "~> 1.0.0"},
     {:exrm, "~> 0.14.2" }]
  end

  defp servicetypes do
    [OPAL: Glossolalia.Services.OPAL, DDD: Glossolalia.Services.DDD]
  end

  defp services do
    [
        elcid: [url: 'http://localhost:8000', type: :OPAL],
#        renal: [url: 'http://localhost:8080', type: :OPAL],
        ddd:   [url: 'http://localhost:4000', type: :DDD ]
    ]
  end

  defp translations do
    [
        elcid: [
                [ from: :accept, to: [
                            { :ddd,   :write     },
                            { :elcid, :broadcast }
                        ] ]
#                [ from: :accept, to: [  ] ]
            ],
        # renal: [
        #         [from: :accept, to: [ {:elcid, :write}, {:ddd, :write} ] ]
        #     ]
    ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
