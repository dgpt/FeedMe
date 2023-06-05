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
      sync_location(headers, row)
      sync_business(headers, row)
    end)
  end

  defp sync_location(headers, row) do
    Enum.zip(headers, row)
    |> Enum.reduce(%{}, fn {key, value}, acc ->
      mapped_key = map_to_location(key)

      if is_nil(mapped_key) do
        acc
      else
        Map.put(acc, mapped_key, value)
      end
    end)
    |> Location.upsert()
  end

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
      "locationid" => :id,
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
