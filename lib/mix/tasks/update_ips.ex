defmodule Mix.Tasks.Update.Ips do
  use Mix.Task

  @urls [
    "https://www.cloudflare.com/ips-v4",
    "https://www.cloudflare.com/ips-v6"
  ]

  @shortdoc "Fetches the latest IPs from CloudFlare."

  def run(_) do
    System.cmd("rm", ["ips-v4", "ips-v6"])
    for url <- @urls, do: fetch url
  end

  defp fetch(url) do
    IO.puts "Fetching #{url}"
    System.cmd("wget", ["--quiet", url])
  end

end
