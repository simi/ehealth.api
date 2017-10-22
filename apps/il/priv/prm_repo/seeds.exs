# PRM seed data

alias Il.PRM.GlobalParameters.Schema, as: GlobalParameter
alias Il.PRMRepo

"priv/prm_repo/fixtures/global_parameters.json"
|> File.read!
|> Poison.decode!(as: [%GlobalParameter{}])
|> Enum.map(&PRMRepo.insert/1)
