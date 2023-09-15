class Customer < ApplicationRecord
  has_many :customer_subscriptions, dependent: :destroy
  has_many :subscriptions, through: :customer_subscriptions

  validates_presence_of :first_name, :last_name, :email, :address
end