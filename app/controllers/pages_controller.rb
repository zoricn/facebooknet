require 'koala'
require 'json'
class PagesController < ApplicationController
  #before_filter :authenticate_user!, :except => "index"
  #before_filter :auth_koala!, :only => "dashboard"
  #before_filter :verify_access_token, :only => "index"

  def index
    @graph = Koala::Facebook::API.new(session['access_token'])
    @profile = @graph.get_object("me")
   @current_token = session['access_token']
  end

  def dashboard
#    url = session['oauth'].url_for_access_token(params[:code])
		#result = session['oauth'].fetch_token_string(params[:code])
		# => "access_token=#{access_token}&expires=#{seconds_from_now}"
#body = response
#JSON.parse(body)['access_token']

    #access_token = 	session['oauth'].parse_token_string(params[:code])
    #request_authorization
#session['oauth'].get_access_token(params[:code])
debugger
    @graph = Koala::Facebook::API.new(params[:code])
    @fb = @graph.get_object("me")
    #@friends = get_friends(@graph)
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
