require "rails_helper"

RSpec.describe 'merchant_items api', type: :request do
  it "can find all items for a merchant" do
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)
    item3 = create(:item, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data']).to be_instance_of(Array)
    expect(json['data'].count).to eql(3)
    expect(json['data'][0]['id']).to eql(item1.id.to_s)
    expect(json['data'][1]['id']).to eql(item2.id.to_s)
    expect(json['data'][2]['id']).to eql(item3.id.to_s)
  end
end
