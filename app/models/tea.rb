class Tea < ApplicationRecord
  has_many :tea_subscriptions, dependent: :destroy
  has_many :subscriptions, through: :tea_subscriptions
end