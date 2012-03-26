require 'koala'
class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => "index"
  before_filter :auth_koala!, :only => "dashboard"

  def index

  end

  def dashboard
    @current_fb_user = @graph.get_object("me")
    @friends = @graph.get_connections("me", "friends", "fields" => ["birthday", "name"]).first 20
  end

  private

  def auth_koala!
    @graph = Koala::Facebook::GraphAPI.new(current_user.token)
  end

end
