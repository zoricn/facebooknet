require 'koala'
class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => "index"
  before_filter :auth_koala!, :only => "dashboard"

  def index

  end

  def dashboard
    @current_fb_user = @graph.get_object("me")
    @friends = get_friends(@graph)
  end

  private

  def auth_koala!
    @graph = Koala::Facebook::GraphAPI.new(current_user.token)
  end

  def get_friends(graph)
    friends = graph.get_connections("me", "friends", "fields" => ["birthday", "name"])
    friends.sort! { |a,b| a["name"].downcase <=> b["name"].downcase }.first 20
  end

end
