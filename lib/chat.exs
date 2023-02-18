defmodule Demo.Chat do
  def send_message(to, message) do
    :timer.sleep(10000)
    send(to, {self(), message})
  end

  def receive_message() do
    receive do
      {pid, message} -> IO.puts("#{inspect(pid)} says: #{message}")
    end
  end
end
