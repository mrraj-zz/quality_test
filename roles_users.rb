class RolesUser < ActiveRecord::Base
  attr_accessible :user_id, :role_id

  has_and_belongs_to_many :users
end
