require "rails_helper"

RSpec.describe 'ItemMerchant API', type: :request do
  it "can show merchant asscoicated with item id" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    merchant2 = create(:merchant)
    create(:item, merchant_id: merchant2.id)

    get "/api/v1/items/#{item1.id}/merchant"

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data']).to be_instance_of(Hash)
    expect(json['data']['id']).to eql(merchant1.id.to_s)
  end
end
