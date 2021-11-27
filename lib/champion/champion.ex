defmodule Champion.Search do
  alias Utilities

  def search_champion(name),
    do:
      get_champions(
        "https://ddragon.leagueoflegends.com/cdn/#{Utilities.get_version()}/data/ko_KR/champion/#{
          Utilities.parse_champion(name)
        }.json",
        Utilities.parse_champion(name)
      )

  defp get_champions(url, name),
    do:
      HTTPoison.get!(url).body
      |> get_name(name)
      |> Utilities.copy()

  defp get_name(body, name), do: Poison.decode!(body)["data"][name]["name"]
end
