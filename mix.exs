defmodule Plug.Cloudflare.Mixfile do
  use Mix.Project

  @source_url "https://github.com/c-rack/plug_cloudflare"
  @version "1.3.0"

  def project do
    [
      app: :plug_cloudflare,
      build_embedded: Mix.env() == :prod,
      deps: [
        {:cidr, ">= 1.1.0"},
        {:credo, ">= 0.3.5", only: [:dev, :test]},
        {:ex_doc, ">= 0.0.0", only: [:dev]},
        {:plug, ">= 1.1.2"},
      ],
      docs: docs(),
      description: """
      Convert CloudFlare's CF-Connecting-IP header to Plug.Conn's remote_ip field.
      """,
      elixir: ">= 1.0.2",
      package: %{
        maintainers: ["Constantin Rack"],
        files: [
          "ips-v4",
          "ips-v6",
          "lib",
          "mix.exs",
          "LICENSE",
          "README.md"
        ],
        licenses: ["Apache-2.0"],
        links: %{
          "GitHub" => @source_url
        }
      },
      start_permanent: Mix.env() == :prod,
      version: @version
    ]
  end

  def application do
    [applications: [:cidr, :plug]]
  end

  defp docs do
    [
      extras: [
        LICENSE: [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "#{@version}",
      formatters: ["html"]
    ]
  end
end
