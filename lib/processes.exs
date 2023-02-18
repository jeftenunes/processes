defmodule Demo do
  def work do
    :timer.sleep(5000)
    IO.puts("hello from process: #{inspect(self())}")
  end

  def work_with_parenthesis(a, b, c) do
    :timer.sleep(5000)
    IO.puts("arg1: #{a}")
    IO.puts("arg2: #{b}")
    IO.puts("arg2: #{c}")
  end

  def run do
    IO.puts("Call hello from process")
    spawn(fn -> work() end)
  end

  def run_with_params do
    spawn(Demo, :work_with_parenthesis, ["param1", "param2", "param3"])
  end

  def closure(arg) do
    IO.puts("Arg received by the closure: #{arg}")
  end

  @doc """
      As spawn triggers a new, separate and isolated process and processes are actors, so this process don't share any memory (and anything) among themselves, the var
      param will be deeply copied and passed to the closure
  """
  def run_closure() do
    param = "ababublebublebuble"

    spawn(fn ->
      closure(param)
    end)
  end
end
