defmodule FeedMe.Type.Coordinates do
  use Ecto.Type

  def type, do: :map

  def cast(coords) when is_binary(coords) do
    coords_regex = ~r{\(?(.+),(.+)\)?}

    [latitude, longitude] =
      coords_regex
      |> Regex.run(coords, capture: :all_but_first)
      |> Enum.map(fn str ->
        str |> String.trim() |> String.trim_trailing("°")
      end)

    {:ok, {latitude, longitude}}
  end

  def cast(%{longitude: longitude, latitude: latitude}) do
    {:ok, {latitude, longitude}}
  end

  def cast(_), do: :error

  def load(%{latitude: _, longitude: _} = coords), do: cast(coords)

  def dump({latitude, longitude}) do
    %{latitude: latitude, longitude: longitude}
  end

  def dump(_), do: :error

  def serialize({latitude, longitude}) do
    "(#{latitude},#{longitude})"
  end
end
