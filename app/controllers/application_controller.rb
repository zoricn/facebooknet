class ApplicationController < ActionController::Base
  protect_from_forgery
  #layout :dynamic_layout

  def render404
    render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, :layout => false
    return true
  end

  def authenticate_user!
    redirect_to root_path, :alert => "You must sign in first" if current_user.nil?
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User)
        dashboard_path
      else
        super
      end
  end

  def current_token
    session['access_token']
  end

  # Control which layout is used.
  def dynamic_layout
    if current_user.nil?
      'application'
    else
      'dashboard'
    end
  end
=begin
  def request_authorization
      # FB doesn't like port numbers in the return URL in canvas apps so only use for local dev
=begin
      @oauth = Koala::Facebook::OAuth.new(ENV['AST_FACEBOOK_APP_ID'], ENV['AST_FACEBOOK_APP_SECRET'],"http://astrology.local:3000/dashboard/")
      info1 = @oauth.get_user_info_from_cookies(cookies)
debugger
      redirect_to @oauth.url_for_oauth_code(:permissions => 'user_birthday,friends_birthday')#session['oauth'].url_for_oauth_code(:permissions => 'user_birthday,friends_birthday')

      full_host = request.host
      full_host += ':' + request.port.to_s if request.host == 'localhost'
      return_url = "#{request.protocol}#{full_host}#{request.fullpath}"
      logger.info 'FB Auth Return URL: ' + return_url
      session['oauth'] = Koala::Facebook::OAuth.new(ENV['AST_FACEBOOK_APP_ID'], ENV['AST_FACEBOOK_APP_SECRET'], "http://astrology.local:3000/dashboard/")
      redirect_to session['oauth'].url_for_oauth_code(:permissions => 'user_birthday,friends_birthday')
  end
=end
  private

    def request_authorization
      # FB doesn't like port numbers in the return URL in canvas apps so only use for local dev
      full_host = request.host
      full_host += ':' + request.port.to_s if request.host == 'localhost'
      return_url = "#{request.protocol}#{full_host}#{request.fullpath}"
      logger.info 'FB Auth Return URL: ' + return_url
      session['oauth'] = Koala::Facebook::OAuth.new(ENV['AST_FACEBOOK_APP_ID'], ENV['AST_FACEBOOK_APP_SECRET'], return_url)
      redirect_to session['oauth'].url_for_oauth_code(:permissions => 'user_birthday,friends_birthday')
    end

    def verify_access_token
      unless session['access_token']
        if session['oauth'] && params[:code]
          # Use the code returned by Facebook to get an access token
          session['access_token'] = session['oauth'].get_access_token(params[:code])
        else
          # Coming in cold so ask for auth
          request_authorization && return
        end
      end
      @graph = Koala::Facebook::API.new(session['access_token'])

      # Need to get an actual object to test the access token
      @profile = @graph.get_object("me")

    rescue Koala::Facebook::APIError
      session['access_token'] = nil
      request_authorization
    end

end
