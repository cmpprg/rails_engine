require "rails_helper"

RSpec.describe 'Items API', type: :request do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json).to have_key('data')
    expect(json['data']).to be_instance_of(Array)
    expect(json['data'].first).to have_key('type')
    expect(json['data'].first).to have_key('id')
    expect(json['data'].first).to have_key('attributes')
    expect(json['data'].first['attributes']).to have_key('name')
    expect(json['data'].first['attributes']).to have_key('description')
    expect(json['data'].first['attributes']).to have_key('unit_price')
    expect(json['data'].first).to have_key('relationships')
    expect(json['data'].first['relationships']).to have_key('merchant')
  end

  it "can send one item from id" do
    
  end
end
