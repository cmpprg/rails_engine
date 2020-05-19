require "rails_helper"

RSpec.describe 'Merchant Find API', type: :request do
  before(:each) do
    Merchant.destroy_all
  end

  it "can find a merchant from name attribute case insensitive" do
    create_list(:merchant, 2, name: 'not_this_one')
    merchant = create(:merchant, name: 'rigHt_one')
    create_list(:merchant, 2, name: 'not_this_one')

    get '/api/v1/merchants/find?name=Right_one'

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data']['id']).to eql(merchant.id.to_s)
    expect(json['data']['attributes']['name']).to eql(merchant.name)
  end

  it "can find a merchant from partial name attribute" do
    create_list(:merchant, 2, name: 'not_this_one')
    merchant = create(:merchant, name: 'RiGhT_one')
    create_list(:merchant, 2, name: 'not_this_one')

    get '/api/v2/merchants/find?name=t_one'

    expect(response).to be_succdessful

    json = JSON.parse(response.body)

    expect(json['data']['id']).to eql(merchant.id.to_s)
    expect(json['data']['attributes']['name']).to eql(merchant.name)
  end

  it "can find merchant from created_at date" do
    create_list(:merchant, 2, name: 'not_this_one')
    merchant = create(:merchant, name: 'RiGhT_one')
    create_list(:merchant, 2, name: 'not_this_one')
  end

  # it "can find merchant from multiple attributes" do
  #   merchant1 = create(:merchant, name: 'ryan')
  #   sleep(1.second)
  #   merchant2 = create(:merchant, name: 'ryan')
  #
  #   get "/api/v1/merchants/find?name=ryan&created_at=#{merchant1.created_at}"
  #
  #   expect(response).to be_successful
  #
  #   json = JSON.parse(response.body)
  #
  #   expect(json['data']).to be_instance_of(Hash)
  #   expect(json['data']['id']).to eql(merchant1.id.to_s)
  #   expect(json['data']['id']).to_not eql(merchant2.id.to_s)
  # end

  it "can find all records with a particular attribute." do

  end
end
