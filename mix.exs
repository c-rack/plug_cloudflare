defmodule Plug.Cloudflare.Mixfile do
  use Mix.Project

  def project do
    [
      app: :plug_cloudflare,
      build_embedded: Mix.env == :prod,
      deps: [
        {:cidr,  ">= 1.0.0"},
        {:credo, ">= 0.3.5", only: [:dev, :test]},
        {:plug,  ">= 1.1.2"}
      ],
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
        licenses: ["Apache License 2.0"],
        links: %{
          "GitHub" => "https://github.com/c-rack/plug_cloudflare"
        }
      },
      start_permanent: Mix.env == :prod,
      version: "1.3.0"
    ]
  end

  def application do
    [applications: []]
  end

end
