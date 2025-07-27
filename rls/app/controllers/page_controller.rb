class PageController < ApplicationController
  def quote
    id = params[:id]

    if id
      quote = Quote.find(id)
      @quote = quote.quote
      @author = quote.author
    else
      count = Quote.count_by_sql("SELECT COUNT(*) FROM quotes")
      random_id = rand(1..count)
      quote = Quote.find(random_id)
      @quote = quote.quote
      @author = quote.author
    end

    render "quote"
  end
end
