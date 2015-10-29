defmodule Plug.CloudFlare do
  
  @moduledoc """
  Parses CloudFlare's CF-Connecting-IP header into Plug.Conn's remote_ip field.
  """
  
  @doc "Callback implementation for Plug.init/1"
  def init(options), do: options

  @doc "Callback implementation for Plug.call/2"
  def call(conn, _options) do
    case (conn.remote_ip |> is_from_cloudflare) do
      true  -> Plug.Conn.get_req_header(conn, "cf-connecting-ip") |> parse(conn)
      false -> conn
    end
  end

  defp parse([], conn), do: conn
  defp parse([ip_address], conn) do
    case (ip_address |> String.to_char_list |> :inet.parse_address) do
      {:ok, remote_ip} -> %Plug.Conn{conn | remote_ip: remote_ip}
      {:error, _}      -> conn
    end
  end

  cidrs =
    Path.join([__DIR__, "../ips-v4"])
    |> File.stream!([], :line)
    |> Enum.to_list
    |> Enum.map(&CIDR.parse/1)
    |> Enum.map(&Macro.escape/1)
    
  defp is_from_cloudflare(ip), do: is_from_cloudflare(unquote(cidrs), ip)
  defp is_from_cloudflare([h|t], ip), do: CIDR.match!(h, ip) or is_from_cloudflare(t, ip)
  defp is_from_cloudflare([], _ip), do: false
  
end
