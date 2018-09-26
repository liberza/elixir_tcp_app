defmodule TcpApp.Protocol.Primitive do

  def decode(<<"S"        ::  utf8, 
                len       ::  32-little-unsigned-integer, 
                value     ::  binary-size(len), 
                rest      ::  binary>>) do
    {:string, value, rest}
  end

  def decode(<<"D"        ::  utf8, 
                value     ::  32-little-unsigned-integer, 
                rest      ::  binary>>) do
    {:dword, value, rest}
  end

  def decode(<<"W"        ::  utf8,
                value     ::  16-little-unsigned-integer,
                rest      ::  binary>>) do
    {:word, value, rest}
  end

  def decode(<<>>) do
    {:nil}
  end
  
  def encode(:string, value) do
    <<"S"              ::  utf8, 
      byte_size(value) ::  32-little-unsigned-integer
    >> <> value
  end

  def encode(:dword, value) do
    <<"D"   :: utf8, 
      value :: 32-little-unsigned-integer>>
  end

  def encode(:word, value) do
    <<"W"   :: utf8, 
      value :: 16-little-unsigned-integer>>
  end

end
