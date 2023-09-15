require 'rails_helper'

describe 'Subscription API' do
  it 'sends a list of subscriptions' do
    customer1 = create(:customer)
    id =  customer1.id
    create_list(:subscription, 3)
    customer1.customer_subscriptions.create(subscription_id: Subscription.first.id)

    get "/api/v1/customers/#{id}/subscriptions"

    expect(response).to be_successful
    expect(response.status).to eq(201)

    subscriptions_json = JSON.parse(response.body, symbolize_names: true)
    subscriptions = subscriptions_json[:data]

    # expect(subscriptions.count).to eq(3)
    expect(customer1.subscriptions.count).to eq(1)

    subscriptions.each do |subscription|
      expect(subscription).to have_key(:id)
      expect(subscription[:id]).to be_an(String)

      expect(subscription).to have_key(:type)
      expect(subscription[:type]).to eq('subscription')

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

  it 'can create a new subscription' do
    customer1 = create(:customer)
    customer2 = create(:customer)
    id1 = customer1.id
    id2 = customer2.id

    subscription_params = {
      title: "Pu'erh Tea",
      price: 45,
      status: 1,
      frequency: "monthly"
    }
    subscription_paramz = {
      title: "Oolong Tea",
      price: 15,
      status: 0,
      frequency: "monthly"
    }

    headerz = { 'CONTENT_TYPE' => 'application/json' }

    post "/api/v1/customers/#{id2}/subscriptions", headers: headerz, params: JSON.generate(subscription_paramz)
    post "/api/v1/customers/#{id1}/subscriptions", headers: headerz, params: JSON.generate(subscription_params)

    older_subscription = Subscription.first
    new_subscription = Subscription.last
    
    expect(response).to be_successful

    expect(new_subscription.title).to eq(subscription_params[:title])
    expect(new_subscription.title).to be_a(String)
    expect(new_subscription.title).to eq("Pu'erh Tea")

    expect(new_subscription.price).to eq(subscription_params[:price])
    expect(new_subscription.price).to be_a(Integer)

    expect(new_subscription.status).to be_a(String)
    expect(new_subscription.status).to eq('cancelled')

    expect(new_subscription.frequency).to eq(subscription_params[:frequency])
    expect(new_subscription.frequency).to be_a(String)
    
    expect(older_subscription.title).to eq(subscription_paramz[:title])
    expect(older_subscription.title).to be_a(String)
    expect(older_subscription.title).to eq("Oolong Tea")

    expect(older_subscription.price).to eq(subscription_paramz[:price])
    expect(older_subscription.price).to be_a(Integer)

    expect(older_subscription.status).to be_a(String)
    expect(older_subscription.status).to eq('active')

    expect(older_subscription.frequency).to eq(subscription_paramz[:frequency])
    expect(older_subscription.frequency).to be_a(String)

    expect(customer1.subscriptions.first.title).to eq(subscription_params[:title])
    expect(customer2.subscriptions.first.title).to_not eq(subscription_params[:title])
    expect(customer2.subscriptions.first.title).to eq(subscription_paramz[:title])
  end
end
