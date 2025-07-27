class PageController < ApplicationController
  def quote
    id = params[:id]

    @quote = "Jadi gini"
    @author = "Billy Editiano #{id}"

    render "quote"
  end
end
