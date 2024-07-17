defmodule GenericServer do
  def start(callback_module) do
    initial_state = callback_module.init()

    spawn(fn -> loop(callback_module, initial_state) end)
  end

  def cast(pid, req) do
    send(pid, {:cast, req})
    :ok
  end

  def call(from, req) do
    send(from, {:call, req, self()})

    receive do
      {:reply, reply} ->
        reply
    end
  end

  defp loop(callback_module, state) do
    receive do
      {:cast, req} ->
        {:noreply, new_state} = callback_module.handle_cast(req, state)
        loop(callback_module, new_state)

      {:call, req, from} ->
        {:reply, {reply, new_state}} = callback_module.handle_call(req, from, state)

        send(from, {:reply, reply})
        loop(callback_module, new_state)
    end
  end
end
