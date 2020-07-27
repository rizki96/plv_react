defmodule PlvReactWeb.Todos.AddTodoFormComponent do
    use Phoenix.LiveComponent
    use Phoenix.HTML

    require Logger

    def render(assigns) do
        ~L"""
        <div class="add_todo_form">
            <%= f = form_for :todo, "#", [id: "add_todo_form", phx_submit: :add_todo] %>
                <%= text_input f, :text %>
                <div>
                    <%= submit "Add Todo", phx_disable_with: "Adding..." %>
                </div>
            </form>
        </div>
        """
    end

    def mount(socket) do
        {:ok, socket}
    end

    def update(params, socket) do
        Logger.log(:debug, "#{inspect params}")
        {:ok, socket}
    end
end