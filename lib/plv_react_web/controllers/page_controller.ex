defmodule PlvReactWeb.PageController do
    use PlvReactWeb, :controller

    
    def index(conn, %{"name" => name} = _params) do
        render(conn, "index.html", name: name)
    end

    # default
    def index(conn, _params) do
        render(conn, "index.html", name: "react")
    end

end