# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Il.Repo.insert!(%Il.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Il.Dictionaries.Dictionary
alias Il.Repo

# truncate table
Repo.delete_all(Dictionary)

"priv/repo/fixtures/dictionaries.json"
|> File.read!
|> Poison.decode!(as: [%Dictionary{}])
|> Enum.each(&Repo.insert!/1)
