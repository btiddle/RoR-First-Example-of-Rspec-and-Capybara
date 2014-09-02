class User < ActiveRecord::Base
  validates :name, :email, :address, presence: true

  def user_details
    "#{self.email} #{self.address}"
  end
end
