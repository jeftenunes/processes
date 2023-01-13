defmodule ProcessesTest do
  use ExUnit.Case
  doctest Processes

  test "simulates a long-running query" do
    assert Processes.long_running_qry() === "qry_def results"
  end
end
