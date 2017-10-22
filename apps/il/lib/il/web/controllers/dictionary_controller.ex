defmodule Il.Web.DictionaryController do
  @moduledoc false

  use Il.Web, :controller

  alias Il.Dictionaries
  alias Il.Dictionaries.Dictionary

  action_fallback Il.Web.FallbackController

  def index(conn, params) do
    with {:ok, dictionaries} <- Dictionaries.list_dictionaries(params) do
      render(conn, "index.json", dictionaries: dictionaries)
    end
  end

  def update(conn, %{"name" => name} = dictionary_params) do
    with {:ok, %Dictionary{} = dictionary} <- Dictionaries.create_or_update_dictionary(name, dictionary_params) do
      render(conn, "show.json", dictionary: dictionary)
    end
  end
end
