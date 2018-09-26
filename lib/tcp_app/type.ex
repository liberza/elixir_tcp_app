defmodule TcpApp.Type do
  alias TcpApp.Format

  @msg_types %{
    # Example message types
    0001 => :client_server_hello,
    0002 => :server_client_hello,
    0003 => :ping,
    0004 => :pong

    # add more types here as needed
  }
  
  # Number-to-atom
  def decode(value) do
    Map.get(@msg_types, value)
  end

  # Use macros to generate some useful functions.
  for {value, name} <- @msg_types do 
    # Atom-to-number
    def encode(unquote(name)) do
      unquote(value)
    end 

    # Number-to-format - using this directly will speed up parsing
    def get_format(unquote(value)) do
      Format.get(unquote(name))
    end
  end

end
