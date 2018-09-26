defmodule TcpApp.Client do
  alias TcpApp.{Type}
  alias TcpApp.Protocol.{Header, Payload}

  # A test of our parser. Build a message manually, then parse & print it.
  # This will create a :server_client_hello message.
  def try_it() do
    payload =
      <<
        "S",
        String.length("hello world") :: 32-little,
        "hello world",
        "W",
        100 :: 16-little-unsigned-integer,
        "D",
        200 :: 32-little-unsigned-integer
      >>
    header =
      <<
        0001 :: 16-big,
        0 :: 32-big,
        byte_size(payload) :: 32-little
      >>

    message = header <> payload
    
    {:ok, stream} = StringIO.open(message)

    print_msg_from_stream(stream)
  end
  
  def print_msg_from_stream(stream) do
    header = IO.binread(stream, Header.header_size) |> Header.parse
    print_header(header)

    IO.binread(stream, header[:payload_size]) 
    |> Payload.parse(header[:type], &Type.get_format/1)
    |> print_payload()

    stream
  end

  @doc "Prints header info for one Header."
  def print_header(header) do
    IO.puts("Type:  #{header[:type]}")
    IO.puts("Size:  #{header[:payload_size]}")
    IO.puts("Flags: #{header[:flags]}")
  end

  @doc "Prints contents of a payload."
  def print_payload([]) do end
  
  def print_payload([var | t]) do
    IO.puts("  #{elem(var, 0)}: #{elem(var, 1)}")
    print_payload(t)
  end

 end
