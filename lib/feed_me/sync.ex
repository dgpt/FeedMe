defmodule FeedMe.Sync do
  alias FeedMe.Location
  alias FeedMe.Business

  @doc """
    Syncs the data from the San Francisco food truck csv to the database
  """
  def sync do
    stream = download_csv()

    headers = stream |> Stream.take(1) |> Enum.to_list() |> hd

    stream
    |> Stream.drop(1)
    |> Enum.each(fn row ->
      {:ok, business} = sync_business(headers, row)
      business |> sync_location(headers, row)
    end)
  end

  defp sync_location(%{id: business_id}, headers, row) do
    change =
      Enum.zip(headers, row)
      |> Enum.reduce(%{}, fn {key, value}, acc ->
        mapped_key = map_to_location(key)

        if is_nil(mapped_key) do
          acc
        else
          mapped_key
          |> parse_location_value(value)
          |> then(fn val -> Map.put(acc, mapped_key, val) end)
        end
      end)
      |> Map.put(:business_id, business_id)

    change
    |> Location.upsert()
  end

  defp parse_datetime(value) do
    {:ok, time} = DateTimeParser.parse_datetime(value)
    time
  end

  defp parse_location_value(:permit_status, value), do: String.downcase(value)
  defp parse_location_value(:approved_at, ""), do: nil
  defp parse_location_value(:approved_at, value), do: parse_datetime(value)
  defp parse_location_value(:expires_at, ""), do: nil
  defp parse_location_value(:expires_at, value), do: parse_datetime(value)
  defp parse_location_value(_, value), do: value

  defp sync_business(headers, row) do
    Enum.zip(headers, row)
    |> Enum.reduce(%{}, fn {key, value}, acc ->
      mapped_key = map_to_business(key)

      if is_nil(mapped_key) do
        acc
      else
        Map.put(acc, mapped_key, value)
      end
    end)
    |> Business.upsert()
  end

  # returns a stream of 2d lists representing the csv
  @url "https://data.sfgov.org/api/views/rqzj-sfat/rows.csv"
  defp download_csv do
    response = Req.get!(@url)

    [response.body] |> CSV.decode!()
  end

  defp map_to_location(key) do
    %{
      "locationid" => :external_id,
      "FacilityType" => :facility_type,
      "LocationDescription" => :description,
      "Address" => :address,
      "FoodItems" => :menu_items,
      "Approved" => :approved_at,
      "ExpirationDate" => :expires_at,
      "Location" => :coordinates,
      "Status" => :permit_status
    }[key]
  end

  defp map_to_business(key) do
    %{
      "Applicant" => :name
    }[key]
  end
end
