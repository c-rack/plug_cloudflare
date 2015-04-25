defmodule Plug.Cloudflare do
  
  @moduledoc """
  Parses Cloudflare's CF-Connecting-IP header into Plug.Conn's remote_ip field
  """
  
  import Plug.Conn, only: [get_resp_header: 2]

  @doc "Callback implementation for Plug.init/1"
  def init(options), do: options

  @doc "Callback implementation for Plug.call/2"
  def call(conn, _options) do
    [remote_ip|_] = conn |> get_resp_header("cf-connecting-ip")
    %Plug.Conn{ conn | remote_ip: remote_ip }
  end

end
