# plug_cloudflare [![Hex.pm Version](http://img.shields.io/hexpm/v/plug_cloudflare.svg)](https://hex.pm/packages/plug_cloudflare) [![Build Status](https://travis-ci.org/c-rack/plug_cloudflare.png?branch=master)](https://travis-ci.org/c-rack/plug_cloudflare)

Inspired by [mod_cloudflare](https://github.com/cloudflare/mod_cloudflare), this [Elixir](http://elixir-lang.org/) [plug](https://github.com/elixir-lang/plug) parses [Cloudflare](https://www.cloudflare.com/)'s `CF-Connecting-IP` HTTP request header into [Plug.Conn](http://hexdocs.pm/plug/Plug.Conn.html)'s `remote_ip` field.

## Setup

To use this plug in your projects, edit your mix.exs file and add the project as a dependency:

```elixir
defp deps do
  [
    { :plug_cloudflare, "~> 1.0.0" }
  ]
end
```

## Usage

This plug should be one of the first ones in your pipeline.
It is therefore recommended to put it in the endpoint instead of a pipeline.

```elixir
defmodule MyApp.Endpoint do
  use Phoenix.Endpoint, otp_app: my_app

  plug Plug.Cloudflare

  # Other plugs omitted for clarity
  
end
```

## License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)
