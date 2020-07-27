defmodule PlvReactWeb.TodoReactLive do
    use Phoenix.LiveView

    import PhoenixLiveReact
    require Logger

    alias PlvReact.Tasks
    
    @impl true
    def render(assigns) do
        ~L"""
        <%= live_react_component("Components.Todo", %{name: @name, todos: @todos}, id: "todo-react-1", merge_props: true) %>
        """
    end

    @impl true
    def mount(_params, _session, socket) do
        # read todos from database
        todos = Tasks.list_task_todos
        socket = socket 
        |> assign(name: "react_component")
        |> assign(todos: todos)

        #{:ok, socket, temporary_assigns: [todos: []]}
        {:ok, socket}
    end

    @impl true
    def handle_info(:refresh_todos, socket) do
        todos = Tasks.list_task_todos
        Logger.log(:debug, "#{inspect todos}")

        {:noreply, socket |> assign(:todos, todos)}
    end

    @impl true
    def handle_event("add_todo", params, %{assigns: %{todos: _todos}} = socket) do
        Logger.log(:debug, "#{inspect params}")
        todo = 
        case Tasks.create_todo(params) do
            {:ok, t} -> t
            {:error, _} -> nil
        end
        #Process.send_after(self(), :refresh_todos, 0)

        {:noreply, socket |> push_event("add_todo_result", %{add_todo: todo})}
    end

    @impl true
    def handle_event("update_todo", params, %{assigns: %{todos: todos}} = socket) do
        Logger.log(:debug, "#{inspect params}")

        old_todo = Tasks.get_todo!(params["id"])
        todo =
        if old_todo do
            case Tasks.update_todo(old_todo, params) do
                {:ok, t} -> t
                {:error, _} -> nil
            end
        else
            nil
        end

        {:noreply, socket |> push_event("update_todo_result", %{update_todo: todo})}
    end
end