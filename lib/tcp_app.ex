defmodule TcpApp do
  defdelegate try_it(), to: TcpApp.Client
end
