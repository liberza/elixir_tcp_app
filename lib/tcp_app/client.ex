defmodule TcpApp.Client do
  alias TcpApp.{Format, Type}
  alias TcpApp.Protocol.{Header, Payload}

  def try_it() do
    # Create an example stream here and parse with
    # print_msg_from_stream/1
  end
  
  def print_msg_from_stream(stream) do
    header = IO.binread(stream, Header.header_size) 
    |> Header.parse
    print_header(header)

    IO.binread(stream, header[:payload_size]) 
    |> Payload.parse(Type.decode(header.type), &Format.get/1)
    |> print_payload()

    stream
  end

  @doc "Prints header info for one Header."
  def print_header({:ok, header, _rest}) do
    IO.puts("Type:  #{header.type}")
    IO.puts("Size:  #{header.size}")
    IO.puts("Flags: #{header.flags}")
  end

  @doc "Prints contents of a payload."
  def print_payload([var | t]) do
    IO.puts("  #{elem(var, 0)}: #{elem(var, 1)}")
    print_payload(t)
  end

 end
