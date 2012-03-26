class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :token, :email, :password, :password_confirmation, :remember_me

  has_and_belongs_to_many :roles

  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  def make_regular
    self.roles << Role.regular
  end

  def revoke_regular
    self.roles.delete(Role.regular)
  end

  def regular?
    role?(:regular)
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20], :token => access_token['credentials']['token'])
    end
  end

end