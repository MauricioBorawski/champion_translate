defmodule Utilities do
  def copy({status = :ok, name, translated}) do
    port_copy(translated)
    {status, name, translated}
  end

  def copy({status = :error, name, translated}), do: {status, name, translated}

  def get_version(),
    do:
      HTTPoison.get!("https://ddragon.leagueoflegends.com/api/versions.json").body
      |> Poison.decode!()
      |> List.first()

  def parse_champion(name) do
    name_unicodes = String.codepoints(name)

    replace_upcase(name_unicodes, List.first(name_unicodes))
  end

  # PRIVATE FUNCTIONS

  defp port_copy(name) do
    port = Port.open({:spawn, get_action()}, [])
    Port.command(port, name)
    Port.close(port)
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

  defp get_action() do
    {os, _} = :os.type()
    if os == :unix, do: "pbcopy", else: "clip.exe"
  end
end
