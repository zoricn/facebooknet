class Users::RegistrationsController < Devise::RegistrationsController
 
  #Dummy override Devise Session Controller
  def create
    super
  end

end

