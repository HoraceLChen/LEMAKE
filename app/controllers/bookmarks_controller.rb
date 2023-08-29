class BookmarksController < ApplicationController
  def index
    @favourites = current_user.favorites
  end
end
