defmodule TcpApp.Format do
  @msg_structure %{
    # 0-length messages
    :ping =>
      :zero_len,

    :pong =>
      :zero_len,
    
    # Regular types with lists of primitives
    :client_server_hello => 
      [hello_msg: :string],

    :server_client_hello =>
      [hello_msg: :string,
       other_data: :word,
       some_more_data: :dword
      ]

    # put more types here as needed
  }
  
  def get(type) do
    Map.get(@msg_structure, type, [])
  end

end
