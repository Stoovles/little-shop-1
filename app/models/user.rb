class User < ApplicationRecord
  attr_accessor :skip_password_validation

  has_many :items
  has_many :orders

  validates_presence_of :name, :street_address, :city, :state, :zip_code, :email_address
  validates :password, presence: true, unless: :skip_password_validation
  validates_uniqueness_of :email_address
  validates :password, confirmation: true, if: :password
  has_secure_password validations: false



  enum role: ['user', 'merchant', 'admin']


end
