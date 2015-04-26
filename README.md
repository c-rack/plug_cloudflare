# plug_cloudflare [![Hex.pm Version](http://img.shields.io/hexpm/v/plug_cloudflare.svg)](https://hex.pm/packages/plug_cloudflare)

Inspired by [mod_cloudflare](https://github.com/cloudflare/mod_cloudflare), this [Elixir](http://elixir-lang.org/) [plug](https://github.com/elixir-lang/plug) parses Cloudflare's `CF-Connecting-IP` HTTP request header into [Plug.Conn](http://hexdocs.pm/plug/Plug.Conn.html)'s `remote_ip` field.

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

```elixir
pipeline :browser do
  plug Plug.Cloudflare
end
```

## License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)
