class Tea < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
end