defmodule Plug.Cloudflare.Mixfile do
  use Mix.Project

  def project do
    [
      app: :plug_cloudflare,
      version: "1.2.0",
      elixir: ">= 1.0.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      description: "Parses CloudFlare's CF-Connecting-IP header into Plug.Conn's remote_ip field.",
      package: package,
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:cidr, ">= 0.2.0"},
      {:plug, ">= 0.11.0"}
    ]
  end

  defp package do
    %{
      contributors: ["Constantin Rack"],
      files: [
        "lib",
        "mix.exs",
        "ips-v4",
        "ips-v6",
        "README.md",
        "LICENSE"
      ],
      licenses: ["Apache License 2.0"],
      links: %{"Github" => "https://github.com/c-rack/plug_cloudflare"}
    }
  end

end
