# plug_cloudflare

[![Build Status](https://travis-ci.org/c-rack/plug_cloudflare.png?branch=master)](https://travis-ci.org/c-rack/plug_cloudflare)
[![Module Version](https://img.shields.io/hexpm/v/plug_cloudflare.svg)](https://hex.pm/packages/plug_cloudflare)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/plug_cloudflare/)
[![Total Download](https://img.shields.io/hexpm/dt/plug_cloudflare.svg)](https://hex.pm/packages/plug_cloudflare)
[![License](https://img.shields.io/hexpm/l/plug_cloudflare.svg)](https://github.com/c-rack/plug_cloudflare/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/c-rack/plug_cloudflare.svg)](https://github.com/c-rack/plug_cloudflare/commits/master)

Inspired by [mod_cloudflare](https://github.com/cloudflare/mod_cloudflare), this [Elixir](http://elixir-lang.org/) [plug](https://github.com/elixir-lang/plug) parses [CloudFlare](https://www.cloudflare.com/)'s `CF-Connecting-IP` HTTP request header into [Plug.Conn](http://hexdocs.pm/plug/Plug.Conn.html)'s `remote_ip` field.


## Setup

To use `:plug_cloudflare` in your projects, edit your `mix.exs` file and add `:plug_cloudflare` as a dependency:

```elixir
defp deps do
  [
    {:plug_cloudflare, ">= 1.2.0"}
  ]
end
```

## Usage

This plug should be one of the first ones in your pipeline.
It is therefore recommended to put it in the endpoint instead of a pipeline.

```elixir
defmodule MyApp.Endpoint do
  use Phoenix.Endpoint, otp_app: my_app

  plug Plug.CloudFlare

  # Other plugs omitted for clarity

end
```

## Behavior

This plug makes an effort to avoid tampering with the remote IP if the app is not running behind Cloudflare.  The remote IP will only be changed by this plug if:

1.  The CF-Connecting-IP header is present
1.  The CF-Connecting-IP header parses to a valid IP address
1.  The peer making the request is a Cloudflare IP address

## Contribution Process

This project uses the [C4.1 process](http://rfc.zeromq.org/spec:22) for all code changes.

> "Everyone, without distinction or discrimination, SHALL have an equal right to become a Contributor under the
terms of this contract."

## Copyright and License

Copyright (c) 2015 Constantin Rack

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [https://www.apache.org/licenses/LICENSE-2.0](https://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
