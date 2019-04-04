class User < ApplicationRecord
  attr_accessor :skip_password_validation
  has_many :items
  has_many :orders

  validates_presence_of :name, :street_address, :city, :state, :zip_code, :email_address
  validates_presence_of :password, unless: :skip_password_validation
  validates_uniqueness_of :email_address
  validates :password, confirmation: true, if: :password
  has_secure_password validations: false

  enum role: ['user', 'merchant', 'admin']

  # # e.g., User.authenticate('penelope@turing.com', 'boom')
  # def self.authenticate(email, password)
  #   if self.find_by(email_address: email) == self.find_by(password: password)
  #     self.find_by(email_address: email)
  #   else
  #     nil
  #   end
  # # if email and password correspond to a valid user, return that user
  # # otherwise, return nil
  # end

end
