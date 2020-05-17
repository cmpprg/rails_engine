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
    expect(json['data'].first['attributes']).to have_key('merchant_id')
  end

  it "can send one item from id" do
    item_id = create(:item).id.to_s

    get "/api/v1/items/#{item_id}"

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data']).to be_instance_of(Hash)
    expect(json['data']['id']).to eql(item_id)
  end

  it "can create a new item" do
    merchant = create(:merchant)
    item_params = {
      name: 'Ryans Code', description: 'The cleanest code in all of the land',
      unit_price: 5.14, merchant_id: merchant.id
    }

    post '/api/v1/items', params: item_params

    expect(response).to be_successful
    item = Item.last
    json = JSON.parse(response.body)

    expect(json['data']['id']).to eql(item.id.to_s)
    expect(json['data']['type']).to eql('item')
    expect(json['data']['attributes']['name']).to eql(item_params[:name])
    expect(json['data']['attributes']['description']).to eql(item_params[:description])
    expect(json['data']['attributes']['unit_price']).to eql(item_params[:unit_price])
    expect(json['data']['attributes']['merchant_id']).to eql(item_params[:merchant_id])
  end

  it "can update existing item" do
    item = create(:item)
    item_params = { name: 'New Name', description: 'New Description' }
    previous_name = Item.last.name
    previous_description = Item.last.description

    put "/api/v1/items/#{item.id}", params: item_params

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data']['id']).to eql(item.id.to_s)
    expect(json['data']['attributes']['name']).to_not eql(previous_name)
    expect(json['data']['attributes']['description']).to_not eql(previous_description)
    expect(json['data']['attributes']['name']).to eql(item_params[:name])
    expect(json['data']['attributes']['description']).to eql(item_params[:description])
  end

  it "can destroy and item from id" do
    item = create(:item)

    expect(Item.exists?(item.id)).to be(true)

    expect { delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(Item.exists?(item.id)).to be(false)

    expect(json['data']['id']).to eql(item.id.to_s)
    expect(json['data']['attributes']['name']).to eql(item.name)
  end
end
