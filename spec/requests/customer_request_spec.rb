require 'rails_helper'

describe 'Customer API' do
  it 'sends a list of customers' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful
    expect(response.status).to eq(200)

    customers_json = JSON.parse(response.body, symbolize_names: true)
    customers = customers_json[:data]

    expect(customers.count).to eq(3)

    customers.each do |customer|
      expect(customer).to have_key(:id)
      expect(customer[:id]).to be_an(String)

      expect(customer).to have_key(:type)
      expect(customer[:type]).to eq('customer')

      expect(customer).to have_key(:attributes)
      expect(customer[:attributes]).to be_a(Hash)

      expect(customer[:attributes]).to have_key(:first_name)
      expect(customer[:attributes][:first_name]).to be_a(String)

      expect(customer[:attributes]).to have_key(:last_name)
      expect(customer[:attributes][:last_name]).to be_a(String)

      expect(customer[:attributes]).to have_key(:email)
      expect(customer[:attributes][:email]).to be_a(String)

      expect(customer[:attributes]).to have_key(:address)
      expect(customer[:attributes][:address]).to be_a(String)
    end
  end

  it 'can create a new customer' do

    customer_params = {
      first_name: 'John',
      last_name: 'Doe',
      email: 'John.Doe@gmail.com',
      address: '1234 1st St. Denver, CO 80202'
    }

    headerz = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/customers', headers: headerz, params: JSON.generate(customer: customer_params)

    new_customer = Customer.last
    
    expect(response).to be_successful
    # expect(response.status).to eq(201)

    expect(new_customer.first_name).to eq(customer_params[:first_name])
    expect(new_customer.first_name).to be_a(String)
    expect(new_customer.first_name).to eq('John')
    
    expect(new_customer.last_name).to eq(customer_params[:last_name])
    expect(new_customer.email).to eq(customer_params[:email])
    expect(new_customer.address).to eq(customer_params[:address])
  end
end
