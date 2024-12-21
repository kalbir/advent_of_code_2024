defmodule Helper do

  def load_file(file_path) do
    case File.read(file_path) do
      {:ok, content} -> content
      {:error, reason} -> {:error, "Failed to read file: #{reason}"}
    end
  end

  def break_into_list(file_content) when is_binary(file_content) do
    String.split(file_content, "\n", trim: true)
  end

  def break_into_map(file_content) when is_binary(file_content) do
    file_content
    |> String.split("\n", trim: true)
    |> Enum.with_index(1)
    |> Enum.into(%{}, fn {line, index} -> {index, line} end)
  end

end
