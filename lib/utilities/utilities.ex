defmodule Utilities do
  def copy(name) do
    port = Port.open({:spawn, "clip.exe"}, [])
    Port.command(port, name)
    Port.close(port)
  end

  def get_version() do
    [h | _t] =
      HTTPoison.get!("https://ddragon.leagueoflegends.com/api/versions.json").body
      |> Poison.decode!()

    h
  end

  def parse_champion(name) do
    name_unicodes = String.codepoints(name)
    first_letter = List.first(name_unicodes)

    List.replace_at(
      name_unicodes,
      0,
      to_upcase(first_letter, String.upcase(first_letter) == first_letter)
    )
    |> Enum.join()
  end

  defp to_upcase(letter, _is_upcase = true), do: letter
  defp to_upcase(letter, _is_upcase), do: String.upcase(letter)
end
