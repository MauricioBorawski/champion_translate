defmodule Champion do
  alias Champion.Search

  defdelegate search_champion(name), to: Search
end
