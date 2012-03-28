class ApplicationController < ActionController::Base
  protect_from_forgery

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

  def request_authorization
      # FB doesn't like port numbers in the return URL in canvas apps so only use for local dev
      full_host = request.host
      full_host += ':' + request.port.to_s if request.host == 'localhost'
      return_url = "#{request.protocol}#{full_host}#{request.fullpath}"
      return_url = "http://apps.facebook.com/astrologydev/"
      logger.info 'FB Auth Return URL: ' + return_url
      session['oauth'] = Koala::Facebook::OAuth.new(ENV['AST_FACEBOOK_APP_ID'], ENV['AST_FACEBOOK_APP_SECRET'], return_url)
      redirect_to session['oauth'].url_for_oauth_code(:permissions => 'user_birthday,friends_birthday')
    end

end
