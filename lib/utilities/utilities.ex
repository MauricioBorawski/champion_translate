defmodule Utilities do
  def copy(name) do
    port = Port.open({:spawn, "clip.exe"}, [])
    Port.command(port, name)
    Port.close(port)
    name
  end

  def get_version(),
    do:
      HTTPoison.get!("https://ddragon.leagueoflegends.com/api/versions.json").body
      |> Poison.decode!()
      |> List.first()

  def parse_champion(name) do
    name_unicodes = String.codepoints(name)

    replace_upcase(name_unicodes, List.first(name_unicodes))
  end

  defp replace_upcase(letters, first_letter),
    do:
      List.replace_at(
        letters,
        0,
        to_upcase(first_letter, String.upcase(first_letter) == first_letter)
      )
      |> Enum.join()

  defp to_upcase(letter, _is_upcase = true), do: letter
  defp to_upcase(letter, _is_upcase), do: String.upcase(letter)
end
