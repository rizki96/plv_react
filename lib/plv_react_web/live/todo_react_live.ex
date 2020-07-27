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
        socket = 
        case Tasks.create_todo(params) do
            {:ok, new_todo} -> push_event(socket, "add_todo_result", %{add_todo: new_todo})
            {:error, _} -> socket
        end
        #Process.send_after(self(), :refresh_todos, 0)

        {:noreply, socket}
    end

    @impl true
    def handle_event("update_todo", params, %{assigns: %{todos: todos}} = socket) do
        Logger.log(:debug, "#{inspect params}")

        old_todo = Tasks.get_todo!(params["id"])
        socket =
        if old_todo do
            case Tasks.update_todo(old_todo, params) do
                {:ok, updated_todo} -> push_event(socket, "update_todo_result", %{update_todo: updated_todo})
                {:error, _} -> socket
            end
        else
            socket
        end

        {:noreply, socket}
    end
end