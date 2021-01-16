defmodule Plug.CloudFlare do
  @moduledoc """
  Parses CloudFlare's CF-Connecting-IP header into Plug.Conn's remote_ip field.
  """

  alias Plug.Conn

  @doc "Callback implementation for Plug.init/1"
  def init(options), do: options

  @doc "Callback implementation for Plug.call/2"
  def call(conn, _options) do
    if is_from_cloudflare(conn.remote_ip) do
      conn |> Conn.get_req_header("cf-connecting-ip") |> parse(conn)
    else
      conn
    end
  end

  defp parse([], conn), do: conn

  defp parse([ip_address], conn) do
    case ip_address |> String.to_charlist() |> :inet.parse_address() do
      {:ok, remote_ip} -> %Conn{conn | remote_ip: remote_ip}
      {:error, _} -> conn
    end
  end

  cidrs_v4 =
    [__DIR__, "../ips-v4"]
    |> Path.join()
    |> File.stream!([], :line)
    |> Enum.to_list()
    |> Enum.map(&CIDR.parse/1)
    |> Enum.map(&Macro.escape/1)

  cidrs_v6 =
    [__DIR__, "../ips-v6"]
    |> Path.join()
    |> File.stream!([], :line)
    |> Enum.to_list()
    |> Enum.map(&CIDR.parse/1)
    |> Enum.map(&Macro.escape/1)

  defp is_from_cloudflare({_, _, _, _} = ip), do: is_from_cloudflare(unquote(cidrs_v4), ip)

  defp is_from_cloudflare({_, _, _, _, _, _, _, _} = ip),
    do: is_from_cloudflare(unquote(cidrs_v6), ip)

  defp is_from_cloudflare([h | t], ip), do: CIDR.match!(h, ip) or is_from_cloudflare(t, ip)
  defp is_from_cloudflare([], _ip), do: false
end
