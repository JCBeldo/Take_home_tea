class Subscription < ApplicationRecord
  has_many :customer_subscriptions, dependent: :destroy
  has_many :customers, through: :customer_subscriptions
end