defmodule Champion.Search do
  alias Utilities

  def search_champion(name),
    do:
      get_champions(
        "https://ddragon.leagueoflegends.com/cdn/#{Utilities.get_version()}/data/ko_KR/champion/#{Utilities.parse_champion(name)}.json",
        Utilities.parse_champion(name)
      )

  defp get_champions(url, name),
    do:
      HTTPoison.get!(url)
      |> get_name(name)
      |> Utilities.copy()
      |> send_name()

  defp get_name(_request = %HTTPoison.Response{body: body, status_code: 200}, name),
    do: {:ok, name, Poison.decode!(body)["data"][name]["name"]}

  defp get_name(_request = %HTTPoison.Response{body: _body, status_code: _code}, name),
    do: {:error, name, "Wrong champion name"}

  defp send_name({status = :ok, name, translated_name}),
    do: %{
      status: status,
      translate: translated_name,
      champion: name,
      copied: "✔"
    }

  defp send_name({status = :error, name, translated_name}),
    do: %{
      status: status,
      error: translated_name,
      champion: name,
      copied: "❌"
    }
end
