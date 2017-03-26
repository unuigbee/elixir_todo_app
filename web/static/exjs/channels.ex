defmodule Channels do
  def connect do
    socket = JS.new Phoenix.Socket, ["/socket"]
    socket.connect();
    channel = socket.channel("client");
    channel.join();
    channel.on "action", fn msg, _ ->
      action = [String.to_existing_atom(msg.action) | msg.params] |> List.to_tuple
      Store.dispatch action
    end
  end
end
