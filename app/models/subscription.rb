class Subscription < ApplicationRecord
  has_many :customer_subscriptions, dependent: :destroy
  has_many :customers, through: :customer_subscriptions
  has_many :tea_subscriptions, dependent: :destroy
  has_many :teas, through: :tea_subscriptions

  validates_presence_of :title, :price, :frequency

  enum :status, [:active, :cancelled]
end