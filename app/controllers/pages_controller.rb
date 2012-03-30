require 'koala'
class PagesController < ApplicationController
  before_filter :get_access_token, :only => "index"

  def index
    request_authorization if @access_token.nil?
    begin
      @graph = KoalaService.graph_from(@access_token)
      @current_person = KoalaService.get_me(@graph)
      @friends = KoalaService.get_twenty_friends(@graph)  
    rescue Koala::Facebook::APIError
    	logger.info "Koala API error"
    end
  end

  private

  def get_access_token
    oauth = Koala::Facebook::OAuth.new(ENV['AST_FACEBOOK_APP_ID'], ENV['AST_FACEBOOK_APP_SECRET']) 
    @access_token = oauth.parse_signed_request(params[:signed_request])["oauth_token"] 
    logger.info "Access token = " + @access_token unless @access_token.nil?
  end

end
