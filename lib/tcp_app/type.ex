defmodule TcpApp.Type do
  # TODO: write a macro to directly map the integer types to each
  # format in TcpApp.Format, for a speed boost.

  @msg_types %{
    # Example message types
    0001 => :client_server_hello,
    0002 => :server_client_hello,
    0003 => :msg_just_a_string,
    0004 => :ping,
    0005 => :pong

    # add more types here as needed
  }
  
  # Number-to-atom
  def decode(value) do
    Map.get(@msg_types, value)
  end

  # Atom-to-number
  for {value, name} <- @msg_types do 
    def encode(unquote(name)) do
      unquote(value)
    end 
  end

end
