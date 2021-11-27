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
      |> send_name(name)

  defp get_name(body, name), do: Poison.decode!(body)["data"][name]["name"]

  defp send_name(translate_name, name),
    do: %{
      status: :ok,
      translate: translate_name,
      champion: name,
      copied: "✔",
    }
end
