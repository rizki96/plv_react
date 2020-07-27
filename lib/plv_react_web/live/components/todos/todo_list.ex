defmodule PlvReactWeb.Todos.TodoListComponent do
    use Phoenix.LiveComponent

    require Logger
    alias PlvReactWeb.Todos.TodoListItemComponent
    alias PlvReact.Tasks

    def render(assigns) do
        ~L"""
        <ul phx-update="append">
            <%= for todo <- @todos do %>
                <%= live_component @socket, TodoListItemComponent, id: todo.id, todo: todo %>
            <% end %>
        </ul>
        """
    end

    def mount(socket) do
        Logger.log(:debug, "#{inspect socket.assigns}")

        {:ok, socket}
    end

end