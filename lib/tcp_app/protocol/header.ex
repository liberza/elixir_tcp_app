defmodule TcpApp.Protocol.Header do
  
  # Constant size in bytes of a header.
  def header_size, do: 10
  
  @doc "Parse the header of a message."
  def parse(binary) do
    with {:ok, type, rest} <- parse_type(binary),
         {:ok, flags, rest} <- parse_flags(rest),
         {:ok, payload_size, rest} <- parse_payload_size(rest) do
      {:ok,
       [type: type,
        flags: flags,
        payload_size: payload_size],
       rest}
    end
  end
  
  defp parse_type(<<type::16-big, rest::binary>>) ,
    do: {:ok, type, rest}

  defp parse_flags(<<flags::32-big, rest::binary>>),
    do: {:ok, flags, rest}

  defp parse_payload_size(<<payload_size::32-little, rest::binary>>),
    do: {:ok, payload_size, rest}
end
