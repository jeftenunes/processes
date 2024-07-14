defmodule Server do
  def start(%{} = state) do
    spawn(fn ->
      initial_state = %{}
      loop(initial_state)
    end)
  end

  def get(caller) do
    send(caller, {:get, self()})

    receive do
      {:response, state} -> state
    end
  end

  def delete(pid, key), do: send(pid, {:delete, key})
  def put(pid, key, value), do: send(pid, {:put, key, value})

  defp loop(state) do
    new_state = receive do
      message -> handle_message(state, message)
    end

    loop(new_state)
  end

  defp handle_message(state, {:put, key, val}),
    do: Map.put(state, key, val)

  defp handle_message(state, {:delete, key}),
    do: Map.delete(state, key)

  defp handle_message(state, {:get, caller}) do
    send(caller, {:response, state})
    state
  end
end
