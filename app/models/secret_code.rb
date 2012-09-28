class SecretCode < ActiveRecord::Base
  attr_accessible :code, :user_id

  validates :code, :presence => true

  belongs_to :user

  SECRET_CODE_LENGTH = 16

  self.per_page = 10

  class << self
    def create_n_secret_codes(code_count = 10)
      self.connection.execute("insert into secret_codes (code, created_at, updated_at) values #{direct_insertion_values(code_count).join(",")}")
    end

    def direct_insertion_values(count)
      values = []
      count.to_i.times { values << "('#{SecureRandom.hex(SECRET_CODE_LENGTH)}', '#{Time.now}', '#{Time.now}')" }
      values
    end

    def unassigned_secret_codes
      @secret_codes ||= self.where(:user_id => nil )      
    end
  end
end
