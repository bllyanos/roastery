defmodule ElxWeb.PageController do
  use ElxWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
