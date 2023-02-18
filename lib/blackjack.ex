defmodule BlackJack do
  def start do
    spawn(fn -> loop({1, 0}) end)
  end

  def draw(server_pid) do
    send(server_pid, {:draw})
  end

  defp loop(curr_state) do
    new_state =
      receive do
        {:draw} ->
          do_draw(curr_state)
      end

    loop(new_state)
  end

  defp verify({player, count}) when count < 21,
    do: IO.puts("Player #{player}, count #{count}")

  defp verify({player, count}) when count == 21,
    do: IO.puts("Player #{player} wins")

  defp verify({player, count}) when count > 21,
    do: IO.puts("Player #{player} lost!")

  defp do_draw({player, current_count}) do
    suit =
      deck()
      |> Enum.random()

    new_round = {player, current_count + get_random_value_from_suit(suit)}
    verify(new_round)
    new_round
  end

  defp deck do
    cards = %{
      :ace => 1,
      :one => 1,
      :two => 2,
      :three => 3,
      :four => 4,
      :five => 5,
      :six => 6,
      :seven => 7,
      :eight => 8,
      :nine => 9,
      :ten => 10,
      :jack => 10,
      :queen => 10,
      :king => 10
    }

    suits = [:clubs, :spades, :hearts, :diamonds]

    suits |> Enum.map(fn suit -> {suit, cards} end)
  end

  defp get_random_value_from_suit({_, cards}) do
    cards
    |> Map.values()
    |> Enum.random()
  end

  # def test(), do: do_draw({1, 0})
end
