require 'koala'
class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => "index"

  def index

  end

  def dashboard
    @graph = Koala::Facebook::GraphAPI.new(current_user.token)
   
    friends = @graph.get_connections("me", "friends")
    @friends_number = friends.length

  end

end
