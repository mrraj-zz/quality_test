class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, 
                  :secret_code_attributes, :update_secret_code_relation

  attr_accessor :update_secret_code_relation

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true,
            :uniqueness => true,
            :format => {:with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i}
  validates :password, :presence => true

  has_one :secret_code
  has_and_belongs_to_many :roles

  accepts_nested_attributes_for :secret_code

  after_create :autosave_associated_records_for_secret_code
  after_create :create_user_role

  def admin?
    self.roles.collect{|role| role.name}.include?("admin")
  end

  def update_secret_code_relation=(secret_code_id)
    self.secret_code = SecretCode.find(secret_code_id)
  end

  def create_user_role
    self.role_ids = [2] # Normal User
  end
end
