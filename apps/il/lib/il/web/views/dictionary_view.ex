defmodule Il.Web.DictionaryView do
  @moduledoc false

  use Il.Web, :view
  alias Il.Web.DictionaryView

  def render("index.json", %{dictionaries: dictionaries}) do
    render_many(dictionaries, DictionaryView, "dictionary.json")
  end

  def render("show.json", %{dictionary: dictionary}) do
    render_one(dictionary, DictionaryView, "dictionary.json")
  end

  def render("dictionary.json", %{dictionary: dictionary}) do
    %{
      name: dictionary.name,
      values: dictionary.values,
      labels: dictionary.labels,
      is_active: dictionary.is_active
    }
  end
end
