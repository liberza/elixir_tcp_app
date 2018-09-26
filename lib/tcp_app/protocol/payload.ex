defmodule TcpApp.Protocol.Payload do
  alias TcpApp.Protocol.Primitive
  
  @doc "Parses the payload based on the user-defined format for that type."
  def parse(payload, type, get_format) do
    get_format.(type)
    |> decode_primitives(payload)
  end

  # Start with nothing in vars, append to the list as we decode.
  def decode_primitives(format, payload, vars \\ [ ])

  # Done decoding.
  def decode_primitives(_format, <<>>, vars) do
    vars
  end
  
  def decode_primitives(:zero_len, _payload, _vars) do
    nil
  end

  # If we don't have a format, decode anyway but don't type-check
  def decode_primitives([], payload, vars) do
    {type, value, rest} = Primitive.decode(payload)
    decode_primitives([], rest, vars ++ [{type, value}])
  end

  # We have a format. Decode with type-checking.
  def decode_primitives([h | t], payload, vars) do
    type = elem(h, 1)
    {^type, value, rest} = Primitive.decode(payload)
    decode_primitives(t, rest, vars ++ [{elem(h, 0), value}])
  end
  
  # Default to no length, in case this is a 0-len msg.
  def serialize_primitives(primitives, payload \\ <<>>)
  
  # Done serializing
  def serialize_primitives([], payload) do
    payload
  end
  
  # This should be a list of tuples, with format {type, var}
  def serialize_primitives([{type, var} | vars], payload) do
    payload <> Primitive.encode(type, var)
    serialize_primitives(vars, payload)
  end
end
