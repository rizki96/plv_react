defmodule PlvReactWeb.TodoLiveviewLive do
    use PlvReactWeb, :live_view

    require Logger
    alias PlvReactWeb.Todos.TodoListComponent
    alias PlvReactWeb.Todos.AddTodoFormComponent
    alias PlvReact.Tasks
    
    @impl true
    def render(assigns) do
        ~L"""
        <div>
            this is <%= @name %>
            <%= live_component @socket, TodoListComponent, id: :todo_list_1, todos: @todos %>
            <%= live_component @socket, AddTodoFormComponent, id: :add_todo_form %>
        </div>
        """
    end

    @impl true
    def mount(_params, _session, socket) do
        todos = Tasks.list_task_todos
        socket = socket 
        |> assign(name: "liveview_component")
        |> assign(todos: todos)

        {:ok, socket, temporary_assigns: [todos: []]}
    end

    @impl true
    def handle_event("add_todo", %{"todo" => todo} = _params, socket) do
        Logger.log(:debug, "#{inspect todo}")
        new_todo = 
        case Tasks.create_todo(todo) do
            {:ok, t} -> t
            {:error, _} -> nil
        end
        socket = assign(socket, :todos, [new_todo])

        {:noreply, socket}
    end

    @impl true
    def handle_event("update_todo:" <> todo_id, params, socket) do
        Logger.log(:debug, "#{inspect params}")
        old_todo = Tasks.get_todo!(todo_id)
        socket =
        if old_todo do
            case Tasks.update_todo(old_todo, 
                (if Enum.member?(params, "value") and params["value"] == "true", 
                    do: %{completed: true}, 
                    else: %{completed: false})) do
                {:ok, t} -> assign(socket, :todos, [t])
                {:error, _} -> socket
            end
        else
            socket
        end

        {:noreply, socket}
    end

end