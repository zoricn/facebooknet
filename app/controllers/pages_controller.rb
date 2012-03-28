require 'koala'
require 'json'
class PagesController < ApplicationController
  #before_filter :authenticate_user!, :except => "index"
  #before_filter :auth_koala!, :only => "dashboard"

  def index
   url = "https://www.facebook.com/dialog/oauth/?client_id=#{ENV['AST_FACEBOOK_APP_ID']}&redirect_uri=http://astrology.local:3000/dashboard/&scope=user_birthday,friends_birthday"
=begin
      session['oauth'] = Koala::Facebook::OAuth.new(ENV['AST_FACEBOOK_APP_ID'], ENV['AST_FACEBOOK_APP_SECRET'], "http://astrology.local:3000/dashboard/")

      redirect_to session['oauth'].url_for_oauth_code(:permissions => 'user_birthday,friends_birthday')
=end
   redirect_to url

  end

  def dashboard
    @graph = Koala::Facebook::API.new(session['oauth'].get_access_token(session[:code]))
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
