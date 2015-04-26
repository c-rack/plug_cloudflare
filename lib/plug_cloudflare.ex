defmodule Plug.Cloudflare do
  
  @moduledoc """
  Parses Cloudflare's CF-Connecting-IP header into Plug.Conn's remote_ip field.
  """
  
  import Plug.Conn, only: [get_req_header: 2]

  @doc "Callback implementation for Plug.init/1"
  def init(options), do: options

  @doc "Callback implementation for Plug.call/2"
  def call(conn, _options) do
    get_req_header(conn, "cf-connecting-ip") |> parse(conn)
  end

  defp parse([], conn), do: conn
  defp parse([ip_address], conn) do
    case ip_address |> String.to_char_list |> :inet.parse_address do
      { :ok, remote_ip } ->
        %Plug.Conn{ conn | remote_ip: remote_ip }
      { :error, _ } ->
        conn
    end
  end

end
