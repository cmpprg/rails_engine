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

    get '/api/v1/merchants/find?name=t_one'

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data']['id']).to eql(merchant.id.to_s)
    expect(json['data']['attributes']['name']).to eql(merchant.name)
  end

  it "can find merchant from created_at date" do
    create_list(:merchant, 2, name: 'not_this_one', created_at: '2012-03-27 14:53:59 UTC')
    merchant = create(:merchant, name: 'RiGhT_one', created_at: '2012-03-28 14:54:09 UTC')
    create_list(:merchant, 2, name: 'not_this_one', created_at: '2012-03-29 14:54:09 UTC')

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data']['id']).to eql(merchant.id.to_s)
    expect(json['data']['attributes']['name']).to eql(merchant.name)
  end

  it "can find merchant from updated_at date" do
    create_list(:merchant, 2, name: 'not_this_one', updated_at: '2012-03-27 14:53:59 UTC')
    merchant = create(:merchant, name: 'RiGhT_one', updated_at: '2012-03-28 14:54:09 UTC')
    create_list(:merchant, 2, name: 'not_this_one', updated_at: '2012-03-29 14:54:09 UTC')

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data']['id']).to eql(merchant.id.to_s)
    expect(json['data']['attributes']['name']).to eql(merchant.name)
  end

  it "can find one merchant from multiple attributes" do
    merchant1 = create(:merchant, name: 'ryan', created_at: '2012-03-28 14:54:09 UTC')
    sleep(1.second)
    merchant2 = create(:merchant, name: 'ryan', created_at: '2012-03-26 14:54:09 UTC')

    get "/api/v1/merchants/find?name=ryan&created_at=#{merchant1.created_at}"

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data']).to be_instance_of(Hash)
    expect(json['data']['id']).to eql(merchant1.id.to_s)
    expect(json['data']['id']).to_not eql(merchant2.id.to_s)
  end

  it "can find all records with a particular name case insensitive and partial." do
    create_list(:merchant, 2, name: 'Ryan')
    create_list(:merchant, 3, name: 'Robert')
    create(:merchant, name: 'RoBertina')
    create_list(:merchant, 2, name: 'Richard')

    get '/api/v1/merchants/find_all?name=roBer'

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data'].length).to eql(4)
    expect(json['data'][0]['attributes']['name']).to eql('Robert')
    expect(json['data'][1]['attributes']['name']).to eql('Robert')
    expect(json['data'][2]['attributes']['name']).to eql('Robert')
    expect(json['data'][3]['attributes']['name']).to eql('RoBertina')
  end

  it "can find all records with a particular created at date" do
    create_list(:merchant, 2, created_at: '2012-03-27 14:53:59 UTC')
    create_list(:merchant, 3, created_at: '2012-03-28 14:53:59 UTC', name: 'the_ones')
    create_list(:merchant, 2, created_at: '2012-03-27 14:53:59 UTC')
    merchant = create(:merchant, created_at: '2012-03-28 14:53:59 UTC', name: 'the_ones')

    get "/api/v1/merchants/find_all?created_at=#{merchant.created_at}"

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data'].length).to eql(4)
    expect(json['data'][0]['attributes']['name']).to eql('the_ones')
    expect(json['data'][1]['attributes']['name']).to eql('the_ones')
    expect(json['data'][2]['attributes']['name']).to eql('the_ones')
    expect(json['data'][3]['attributes']['name']).to eql('the_ones')
  end

  it "can find all records with a particular updated at date" do
    create_list(:merchant, 2, updated_at: '2012-03-27 14:53:59 UTC')
    create_list(:merchant, 3, updated_at: '2012-03-28 14:53:59 UTC', name: 'the_ones')
    create_list(:merchant, 2, updated_at: '2012-03-27 14:53:59 UTC')
    merchant = create(:merchant, updated_at: '2012-03-28 14:53:59 UTC', name: 'the_ones')

    get "/api/v1/merchants/find_all?updated_at=#{merchant.updated_at}"

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data'].length).to eql(4)
    expect(json['data'][0]['attributes']['name']).to eql('the_ones')
    expect(json['data'][1]['attributes']['name']).to eql('the_ones')
    expect(json['data'][2]['attributes']['name']).to eql('the_ones')
    expect(json['data'][3]['attributes']['name']).to eql('the_ones')
  end

  it "can find all records with from multiple attributes" do
    create_list(:merchant, 2, updated_at: '2012-03-27 14:53:59 UTC')
    create_list(:merchant, 3, updated_at: '2012-03-28 14:53:59 UTC', name: 'these_ones')
    create_list(:merchant, 2, updated_at: '2012-03-27 14:53:59 UTC')
    merchant = create(:merchant, updated_at: '2012-03-28 14:53:59 UTC', name: 'this_one')

    get "/api/v1/merchants/find_all?updated_at=#{merchant.updated_at}&name=e_ones"

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data'].length).to eql(3)
    expect(json['data'][0]['attributes']['name']).to eql('these_ones')
    expect(json['data'][1]['attributes']['name']).to eql('these_ones')
    expect(json['data'][2]['attributes']['name']).to eql('these_ones')
  end
end
