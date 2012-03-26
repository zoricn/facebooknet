class Role < ActiveRecord::Base

  has_and_belongs_to_many :users

  def self.admin
    find_by_name("admin")
  end

  def self.regular
    find_by_name("regular")
  end

end
