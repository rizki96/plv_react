defmodule PlvReactWeb.TodoLiveviewLive do
    use Phoenix.LiveView

    require Logger
    
    @impl true
    def render(assigns) do
        ~L"""
        this is <%= @name %>
        """
    end

    @impl true
    def mount(_params, _session, socket) do

        {:ok, socket |> assign(name: "liveview_com")}
    end

end