defmodule ElxWeb.PageController do
  use ElxWeb, :controller
  alias Elx.Repo

  def quotes(conn, _params) do
    count = Repo.aggregate(Elx.Quote, :count)
    IO.inspect(count, label: "count")
    random_id = :rand.uniform(count)
    quote_data = Repo.get!(Elx.Quote, random_id)
    render(conn, :quote, quote: quote_data.quote, author: quote_data.author)
  end

  def quote(conn, %{"id" => id}) do
    quote_data = Repo.get!(Elx.Quote, id)
    render(conn, :quote, quote: quote_data.quote, author: quote_data.author)
  end

  def say(conn, %{"message" => message}) do
    render(conn, :say, message: message)
  end
end
