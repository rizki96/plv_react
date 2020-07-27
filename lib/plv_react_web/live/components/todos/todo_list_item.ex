defmodule PlvReactWeb.Todos.TodoListItemComponent do
    use Phoenix.LiveComponent
    use Phoenix.HTML

    require Logger

    def render(assigns) do
        ~L"""
        <li id="<%= @todo.id %>" phx-update="replace" phx-hook="AddTodoHook">
            <label class='<%= if @todo.completed == true, do: "complete", else: "" %>'>
                <%= checkbox(:todo, :update_todo, phx_click: "update_todo:#{@todo.id}", phx_value: Jason.encode!(@todo), id: "chkbox-#{@todo.id}", checked: @todo.completed) %>
                <%= @todo.text %>
            </label>
        </li>
        """
    end

    def mount(socket) do
        {:ok, socket}
    end

    #def update(params, socket) do
    #    Logger.log(:debug, "#{inspect params}")
    #    {:ok, socket}
    #end
end