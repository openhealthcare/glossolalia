defmodule Glossolalia.Mixfile do
  use Mix.Project

  def project do
    [app: :glossolalia,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps,
     services: services,
     translations: translations,
     servicetypes: servicetypes
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Glossolalia, []},
     applications: [:phoenix, :cowboy, :logger]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "0.8.0"},
      {:cowboy, "~> 1.0.0"},
      {:ehl7, git: "https://github.com/jcomellas/ehl7"},
      {:httpoison, "~> 0.4"}
    ]
  end

  defp servicetypes do
    [OPAL: Glossolalia.Services.OPAL, DDD: Glossolalia.Services.DDD]
  end

  defp services do
    [
        elcid: [url: 'http://localhost:8000', type: :OPAL],
        renal: [url: 'http://localhost:8080', type: :OPAL],
        ddd:   [url: 'http://localhost:4000', type: :DDD ]
    ]
  end

  defp translations do
    [
        elcid: [
                [from: :accept, to: [ {:ddd, :write} ] ]
            ],
        # renal: [
        #         [from: :accept, to: [ {:elcid, :write}, {:ddd, :write} ] ]
        #     ]
    ]
  end


end