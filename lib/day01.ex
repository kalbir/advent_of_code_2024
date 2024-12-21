defmodule Day01 do
  def part1(file) do
    Helper.load_file(file)
      |> Helper.break_into_list()
      |> two_strings()
      |> sort_and_pair_lists()
      |> calc_distance()
  end

  def part2(file) do
   {integer_list, tuple_list} =
      Helper.load_file(file)
        |> Helper.break_into_list()
        |> two_strings()

    multiply(integer_list, how_many_times(tuple_list))
  end

  def two_strings(input) do
      input
      |> Enum.map(fn str ->
        str
        |> String.split()
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)
      |> Enum.unzip()
  end

  def sort_and_pair_lists({list1, list2}) do
    sort1 = Enum.sort(list1)
    sort2 = Enum.sort(list2)

    Enum.zip(sort1, sort2)
  end

  def calc_distance(pair_list) do
    Enum.reduce(pair_list, 0, fn {a, b}, acc -> acc + abs(b - a) end)
  end

  def how_many_times(list) do
    list
      |> Enum.map(fn x -> {x, Enum.count(list, &(&1 == x))} end)
      |> Enum.uniq()
      |> Enum.sort
  end

  def multiply(integers, tuple_list) do
    lookup = Map.new(tuple_list)
    result = Enum.map(integers, fn int ->
      int * Map.get(lookup, int, 0)  # Returns 0 if int isn't found in lookup
    end)

    Enum.sum(result)
  end
end
