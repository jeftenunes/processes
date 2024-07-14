defmodule Processes do
  @moduledoc """
  Documentation for `Processes`.
  """

  @doc """
  Simulation of a long-running query execution.

  ## Examples

      iex> Processes.long_running_qry()


  """
  def long_running_qry(qry) do
    run_qry = fn qry_def ->
      Process.sleep(2000)
      "#{qry_def} results"
    end

    async_qry = fn qry_def ->
      spawn(fn -> IO.puts(run_qry.(qry_def)) end)
    end

    async_qry.(qry)
  end

  def bulk_long_running_queries, do: Enum.each(1..5, fn i ->
    long_running_qry(i)
  end)

  def listen_loop() do
    receive do
      :first -> IO.inspect("first")
      :second -> IO.inspect("second")
    after
      2000 -> send(self(), :first)
    end
  end
end
