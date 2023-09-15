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

  it 'shows a single customer and their subscriptions' do
    customer1 = create(:customer)
    id = customer1.id
    subs = create_list(:subscription, 2)
    # require 'pry'; binding.pry
    cs1 = CustomerSubscription.create!(customer_id: id, subscription_id: subs.first.id)
    cs2 = CustomerSubscription.create!(customer_id: id, subscription_id: subs[1].id)
    # Subscription.create(title: 'Green Tea', price: 15, status: 0, frequency: 'monthly')
    # Subscription.create(title: 'Oolong Tea', price: 30, status: 1, frequency: 'monthly')
    # require 'pry'; binding.pry
    get "/api/v1/customers/#{id}/subscriptions"

    expect(response).to be_successful
    expect(response.status).to eq(201)

    customer_sub_json = JSON.parse(response.body, symbolize_names: true)
   
    customer_subs = customer_sub_json[:data]

    customer_subs.each do |subscription|
      expect(subscription).to have_key(:id)
      expect(subscription[:id]).to be_an(String)

      expect(subscription).to have_key(:type)
      expect(subscription[:type]).to eq('subscription')
      expect(subscription[:type]).to be_a(String)

      expect(subscription).to have_key(:attributes)
      expect(subscription[:attributes]).to be_a(Hash)

      expect(subscription[:attributes]).to have_key(:title)
      expect(subscription[:attributes][:title]).to be_a(String)

      expect(subscription[:attributes]).to have_key(:price)
      expect(subscription[:attributes][:price]).to be_a(Integer)

      expect(subscription[:attributes]).to have_key(:status)
      expect(subscription[:attributes][:status]).to be_a(String)  

      expect(subscription[:attributes]).to have_key(:frequency)
      expect(subscription[:attributes][:frequency]).to be_a(String)
    end
  end
end
