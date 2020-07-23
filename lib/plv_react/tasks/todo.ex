defmodule PlvReact.Tasks.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :text, :completed]}
  schema "task_todos" do
    field :completed, :boolean, default: false
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:text, :completed])
    |> validate_required([:text, :completed])
  end
end
