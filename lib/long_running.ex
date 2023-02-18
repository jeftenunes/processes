defmodule LongRunning do
  @doc """
  Interface method runs in client's process
  """
  def start() do
    spawn(&loop/0)
  end

  @doc """
  Implementation function, runs in the server process
  """
  defp loop do
    receive do
      {:run_qry, caller, qry_def} ->
        send(caller, {:qry_result, run_qry(qry_def)})
    end

    loop()
  end

  @doc """
  receives the pid of database server and qry you want to execute
  """
  def run_async(server_pid, qry_def) do
    send(server_pid, {:run_qry, self(), qry_def})
  end

  @doc """
  Is called when the client wants to get query execution result.
  """
  def get_result do
    receive do
      {:qry_result, result} ->
        result
    after
      5000 -> {:err, :time_out}
    end
  end

  defp run_qry(qry_def) do
    Process.sleep(2000)
    "#{qry_def} result"
  end
end
