class Api::V1::Customers::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:id])
    render json: SubscriptionSerializer.new(customer.subscriptions), status: 201
  end

  def create
    # require 'pry'; binding.pry
    customer = Customer.find(params[:id])
    subscription = Subscription.new(subscription_params)
    if subscription.save
      cr_sub = CustomerSubscription.create(customer_id: customer.id, subscription_id: subscription.id)
      # require 'pry'; binding.pry
      render json: SubscriptionSerializer.new(cr_sub.subscription), status: 201
    else
      render json: { error: subscription.errors.full_messages.to_sentence }, status: 400
    end
  end

  def update
    
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency)
  end
end
