require 'rails_helper'

RSpec.describe 'Merchant Business API', type: :request do
  before(:each) do
    create(:merchant, name: 'Mac')
    create(:item, merchant_id: 1, unit_price: 400)
    create(:invoice, merchant_id: 1)
    create(:invoice_item, item_id: 1, invoice_id: 1, unit_price: 400, quantity: 1)
    create(:transaction, invoice_id: 1, result: 'success')
    create(:invoice, merchant_id: 1)
    create(:invoice_item, item_id: 1, invoice_id: 2, unit_price: 400, quantity: 1)
    create(:transaction, invoice_id: 2, result: 'success')
    create(:invoice, merchant_id: 1)
    create(:invoice_item, item_id: 1, invoice_id: 3, unit_price: 400, quantity: 2)
    create(:transaction, invoice_id: 3, result: 'success')

    create(:merchant, name: 'Lisa')
    create(:item, merchant_id: 2, unit_price: 100)
    create(:invoice, merchant_id: 2)
    create(:invoice_item, item_id: 2, invoice_id: 4, unit_price: 100, quantity: 5)
    create(:transaction, invoice_id: 4, result: 'success')
    create(:invoice, merchant_id: 2)
    create(:invoice_item, item_id: 2, invoice_id: 5, unit_price: 100, quantity: 5)
    create(:transaction, invoice_id: 5, result: 'success')
    create(:invoice, merchant_id: 2)
    create(:invoice_item, item_id: 2, invoice_id: 6, unit_price: 100, quantity: 1)
    create(:transaction, invoice_id: 6, result: 'failed')

    create(:merchant, name: 'Kalhune')
    create(:item, merchant_id: 3, unit_price: 300)
    create(:invoice, merchant_id: 3)
    create(:invoice_item, item_id: 3, invoice_id: 7, unit_price: 300, quantity: 3)
    create(:transaction, invoice_id: 7, result: 'success')
    create(:invoice, merchant_id: 3)
    create(:invoice_item, item_id: 3, invoice_id: 8, unit_price: 300, quantity: 3)
    create(:transaction, invoice_id: 8, result: 'success')
    create(:invoice, merchant_id: 3)
    create(:invoice_item, item_id: 3, invoice_id: 9, unit_price: 300, quantity: 10)
    create(:transaction, invoice_id: 9, result: 'failed')

    create(:merchant, name: 'Rodney')
    create(:item, merchant_id: 4, unit_price: 500)
    create(:invoice, merchant_id: 4)
    create(:invoice_item, item_id: 4, invoice_id: 10, unit_price: 500, quantity: 2)
    create(:transaction, invoice_id: 10, result: 'success')
    create(:invoice, merchant_id: 4)
    create(:invoice_item, item_id: 4, invoice_id: 11, unit_price: 500, quantity: 3)
    create(:transaction, invoice_id: 11, result: 'success')
    create(:invoice, merchant_id: 4)
    create(:invoice_item, item_id: 4, invoice_id: 12, unit_price: 500, quantity: 4)
    create(:transaction, invoice_id: 12, result: 'failed')

    create(:merchant, name: 'Cisco')
    create(:item, merchant_id: 5, unit_price: 200)
    create(:invoice, merchant_id: 5)
    create(:invoice_item, item_id: 5, invoice_id: 13, unit_price: 200, quantity: 6)
    create(:transaction, invoice_id: 13, result: 'success')
    create(:invoice, merchant_id: 5)
    create(:invoice_item, item_id: 5, invoice_id: 14, unit_price: 200, quantity: 8)
    create(:transaction, invoice_id: 14, result: 'success')
    create(:invoice, merchant_id: 5)
    create(:invoice_item, item_id: 5, invoice_id: 15, unit_price: 200, quantity: 1)
    create(:transaction, invoice_id: 15, result: 'failed')

  end
  it 'can return a list of certain number of merchants who made the most revenue' do
    get '/api/v1/merchants/most_revenue?quantity=2'

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data'].length).to eql(2)
    expect(json['data'][0]['attributes']['name']).to eql('Rodney')
    expect(json['data'][1]['attributes']['name']).to eql('Kalhune')
  end
end
