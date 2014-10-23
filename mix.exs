defmodule Glossolalia.Mixfile do
  use Mix.Project

  def project do
    [ app: :glossolalia,
      version: "0.0.1",
      elixir: "~> 1.0.0-rc1",
      elixirc_paths: ["lib", "web"],
      deps: deps,
      services: services,
      translations: translations,
      servicetypes: servicetypes
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Glossolalia, [] },
      applications: [:phoenix, :cowboy, :logger]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:phoenix, "0.4.1"},
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
                from: :accept, to: [ {:renal, :write}, {:ddd, :write} ]
            ],
        renal: [
                from: :accept, to: [ {:elcid, :write}, {:ddd, :write} ]
            ]
    ]
  end
  
end
