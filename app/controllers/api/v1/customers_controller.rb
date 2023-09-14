class Api::V1::CustomersController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def create
    render json: CustomerSerializer.new(Customer.create(customer_params))
  end

  private

  def customer_params
    params.permit(:first_name, :last_name, :email, :address)
  end
end