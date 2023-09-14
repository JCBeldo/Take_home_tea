class Api::V1::CustomersController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: CustomerSerializer.new(Customer.create(customer_params), status: 201)
    else
      render json: { error: customer.errors.full_messages.to_sentence }, status: 400
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :address)
  end
end
