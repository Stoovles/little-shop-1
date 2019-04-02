class User < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip_code, :email_address, :password, :password_confirmation
  validates :email_address, :uniqueness => true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  # validates :password_digest, presence: true
  has_secure_password validations: false

  # # e.g., User.authenticate('penelope@turing.com', 'boom')
  # def self.authenticate(email, password)
  #   if self.find_by(email: email) == self.find_by(password: password)
  #     self.find_by(email: email)
  #   else
  #     nil
  #   end
  # # if email and password correspond to a valid user, return that user
  # # otherwise, return nil
  # end

end
