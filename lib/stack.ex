defmodule Stack do
  def init, do: []

  def handle_cast({:push, elm}, state) do
    {:noreply, [elm | state]}
  end

  def handle_call(:pop, _from, [hd | tl] = _state) do
    {:reply, {hd, tl}}
  end

  def handle_call(:list, _from, state) do
    {:reply, {state, state}}
  end
end
