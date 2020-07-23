defmodule PlvReact.Repo.Migrations.CreateTaskTodos do
  use Ecto.Migration

  def change do
    create table(:task_todos) do
      add :text, :string
      add :completed, :boolean, default: false, null: false

      timestamps()
    end

  end
end
