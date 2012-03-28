require 'koala'
require 'json'
class PagesController < ApplicationController
  before_filter :get_access_token, :only => "index"

  def index
    #request_authorization if @access_token.nil?
    begin
 	    @graph = Koala::Facebook::API.new(@access_token)
      @current_person = @graph.get_object("me")
      @friends = get_friends(@graph)  
    rescue Koala::Facebook::APIError
    	logger.info "Koala API error"
    end

  end

  def dashboard
  end

  private

  def auth_koala!
    @graph = Koala::Facebook::API.new(@access_token)
  end

  def get_friends(graph)
    friends = graph.get_connections("me", "friends", "fields" => ["birthday", "name"])
    friends.sort! { |a,b| a["name"].downcase <=> b["name"].downcase }.first 20
  end

  def get_access_token
    oauth = Koala::Facebook::OAuth.new(ENV['AST_FACEBOOK_APP_ID'], ENV['AST_FACEBOOK_APP_SECRET']) 
    @access_token = oauth.parse_signed_request(params[:signed_request])["oauth_token"] 
    logger.info "Access token = " + @access_token unless @access_token.nil?
  end

end
