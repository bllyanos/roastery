class PageController < ApplicationController
  def quote
    id = params[:id]

    @quote = "Jadi gini"
    @author = "Billy Editiano"

    render "quote"
  end

end
