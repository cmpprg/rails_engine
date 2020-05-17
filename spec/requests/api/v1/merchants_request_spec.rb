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
    
  end

  it "can update an existing merchant" do

  end

  it "can destroy a merchant" do

  end
end
