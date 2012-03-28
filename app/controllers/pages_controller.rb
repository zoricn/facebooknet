require 'koala'
require 'json'
class PagesController < ApplicationController
  #before_filter :authenticate_user!, :except => "index"
  #before_filter :auth_koala!, :only => "dashboard"
  #before_filter :verify_access_token, :only => "index"

  def index
    @oauth = Koala::Facebook::OAuth.new(ENV['AST_FACEBOOK_APP_ID'], ENV['AST_FACEBOOK_APP_SECRET'])
    access_token = @oauth.parse_signed_request(params[:signed_request])["oauth_token"]
    @graph = Koala::Facebook::API.new(access_token)
    @current_person = @graph.get_object("me")
    @friends = get_friends(@graph)  
  end

  def dashboard
  end

  private

  def auth_koala!
    @graph = Koala::Facebook::GraphAPI.new(current_user.token)
  end

  def get_friends(graph)
    friends = graph.get_connections("me", "friends", "fields" => ["birthday", "name"])
    friends.sort! { |a,b| a["name"].downcase <=> b["name"].downcase }.first 20
  end


  
  def koala_oauth
      session['oauth'] = Koala::Facebook::OAuth.new(ENV['AST_FACEBOOK_APP_ID'], ENV['AST_FACEBOOK_APP_SECRET'])
  	
  end

end
