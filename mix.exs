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
      {:phoenix, "~> 1.1"},
      {:phoenix_html, "~> 2.3"},
      {:cowboy, "~> 1.0.0"},
      {:ehl7, git: "https://github.com/jcomellas/ehl7"},
      {:ex_hl7, "~> 0.1.3"},
      {:httpoison, "~> 0.6"},
      {:json, "~> 0.3.0"},
      {:exrm, "~> 0.14.16"},
      {:benchfella, "0.2.0"},
    ]
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


end
