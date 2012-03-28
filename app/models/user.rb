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

  class << self
    extend ActiveSupport::Memoizable

    def config
      @config ||= if ENV['FB_APP_ID'] && ENV['FB_APP_SECRET'] && ENV['FB_SCOPE'] && ENV['FB_CANVAS_URL']
        {
          :client_id     => ENV['AST_FACEBOOK_APP_ID'],
          :client_secret => ENV['AST_FACEBOOK_APP_ID'],
          :scope         => 'user_birthday,friends_birthday',
          :canvas_url    => "http://astronet.herokuapp.com/"
        }
      else
        YAML.load_file("#{Rails.root}/config/facebook.yml")[Rails.env].symbolize_keys
      end
    rescue Errno::ENOENT => e
      raise StandardError.new("config/facebook.yml could not be loaded.")
    end

    def app
      FbGraph::Application.new config[:client_id], :secret => config[:client_secret]
    end

    def auth(redirect_uri = nil)
      FbGraph::Auth.new config[:client_id], config[:client_secret], :redirect_uri => redirect_uri
    end

    def identify(fb_user)
      _fb_user_ = find_or_initialize_by_identifier(fb_user.identifier.try(:to_s))
      _fb_user_.access_token = fb_user.access_token.access_token
      _fb_user_.first_name = fb_user.first_name
      _fb_user_.last_name = fb_user.last_name
      _fb_user_.email = fb_user.email
      _fb_user_.save!
      _fb_user_
    end
  end

end
