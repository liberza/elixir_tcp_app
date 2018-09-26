defmodule TcpApp.Protocol.Header do
  
  # Constant size in bytes of a header.
  def header_size, do: 10
  
  @doc "Parse the header of a message."
  def parse(binary) do
    with <<type         :: 16-big,
	   flags        :: 32-big,
	   payload_size :: 32-little,
	   rest         :: binary>> <- binary do
      {:ok,
       [type: type,
        flags: flags,
        payload_size: payload_size],
       rest}
    end
  end
end
