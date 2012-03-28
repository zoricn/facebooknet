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

end
