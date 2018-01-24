defmodule TestRouter do
  use Plug.Router

  plug :match
  plug :dispatch
  plug Plug.CloudFlare

  get "/" do
    send_resp(conn, 200, "test")
  end

  match _, do: send_resp(conn, 404, "not found")

end

defmodule Plug.CloudFlareTest do
  use ExUnit.Case, async: true
  use Plug.Test

  doctest Plug.CloudFlare

  @opts TestRouter.init([])

  setup do
    Application.put_env(:plug, :validate_header_keys_during_test, true)
  end

  test "sets remote_ip correctly" do
    conn = conn(:get, "/") |> put_req_header("cf-connecting-ip", "192.168.1.1")
    conn = %Plug.Conn{conn | remote_ip: {103, 21, 244, 0}}
    conn = TestRouter.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "test"
    assert conn.remote_ip == {192, 168, 1, 1}
  end

  test "should skip if cf-connecting-ip is not set" do
    conn = conn(:get, "/")
    conn = TestRouter.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "test"
    assert conn.remote_ip == {127, 0, 0, 1}
  end

  test "should skip if cf-connecting-ip is empty" do
    conn = conn(:get, "/") |> put_req_header("cf-connecting-ip", "")
    conn = TestRouter.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "test"
    assert conn.remote_ip == {127, 0, 0, 1}
  end

  test "should skip if cf-connecting-ip is nonsense" do
    conn = conn(:get, "/") |> put_req_header("cf-connecting-ip", "not an ip")
    conn = TestRouter.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "test"
    assert conn.remote_ip == {127, 0, 0, 1}
  end

  test "should skip if not from CloudFlare IP" do
    conn = conn(:get, "/") |> put_req_header("cf-connecting-ip", "199.27.128.1")
    conn = %Plug.Conn{conn | remote_ip: {192, 168, 1, 1}}
    conn = TestRouter.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "test"
    assert conn.remote_ip == {192, 168, 1, 1}
    #103.21.244.0
  end

  test "should not skip if from CloudFlare IP" do
    conn = conn(:get, "/") |> put_req_header("cf-connecting-ip", "192.168.1.1")
    conn = %Plug.Conn{conn | remote_ip: {103, 21, 244, 0}}
    conn = TestRouter.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "test"
    assert conn.remote_ip == {192, 168, 1, 1}
  end

end
