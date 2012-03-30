class ApplicationController < ActionController::Base
  protect_from_forgery

  def render404
    render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, :layout => false
    return true
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User)
        root_path
      else
        super
      end
  end

  def request_authorization
      session['oauth'] = Koala::Facebook::OAuth.new(ENV['AST_FACEBOOK_APP_ID'], ENV['AST_FACEBOOK_APP_SECRET'], ENV['AST_FACEBOOK_CANVAS'])
      redirect_to session['oauth'].url_for_oauth_code(:permissions => 'user_birthday,friends_birthday')
    end

end
