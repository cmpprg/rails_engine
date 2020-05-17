require "rails_helper"

RSpec.describe 'Merchants API', type: :request do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json).to have_key('data')
    expect(json['data']).to be_instance_of(Array)
    expect(json['data'].count).to eql(3)
    expect(json['data'].first).to have_key('id')
    expect(json['data'].first).to have_key('type')
    expect(json['data'].first).to have_key('attributes')
    expect(json['data'].first['attributes']).to have_key('name')
  end

  it "can send one merchant by id" do
    merchant1 = create(:merchant)
    create_list(:merchant, 3)

    get "/api/v1/merchants/#{merchant1.id}"

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data']).to be_instance_of(Hash)
    expect(json['data']['id']).to eql(merchant1.id.to_s)
  end

  it "can create a new merchant" do
    merchant_params = { name: "Ryan Camp" }

    post "/api/v1/merchants", params: merchant_params

    expect(response).to be_successful

    merchant = Merchant.last

    expect(Merchant.count).to eql(1)
    expect(merchant.name).to eql("Ryan Camp")
  end

  it "can update an existing merchant" do
    merchant = create(:merchant)
    previous_name = merchant.name
    merchant_params = { name: 'Ryan Camp Ya!' }

    put "/api/v1/merchants/#{merchant.id}", params: merchant_params

    expect(response).to be_successful

    updated_merchant = Merchant.find(merchant.id)

    expect(updated_merchant.name).to_not eql(previous_name)
    expect(updated_merchant.name).to eql('Ryan Camp Ya!')
  end

  it "can destroy a merchant" do
    merchant = create(:merchant)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.exists?(merchant.id)).to eql(false)
    expect(Merchant.count).to eql(0)
  end
end
