defmodule Il.DuplicatePersons do
  @moduledoc false

  use Supervisor

  alias Il.DuplicatePersons.Signals
  alias Il.DuplicatePersons.CleanupTasks

  def start_link do
    Supervisor.start_link(__MODULE__, [], [name: __MODULE__])
  end

  def init(_) do
    children = [
      worker(Signals, []),
      supervisor(Task.Supervisor, [[name: CleanupTasks]], [restart: :permanent])
    ]

    supervise(children, [strategy: :one_for_one])
  end
end
