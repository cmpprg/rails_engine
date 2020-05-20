require 'rails_helper'

RSpec.describe 'Merchant Business API', type: :request do
  before(:each) do
    Merchant.destroy_all
    Item.destroy_all
    Invoice.destroy_all
    InvoiceItem.destroy_all
    Transaction.destroy_all
    Customer.destroy_all
    customer = create(:customer)
    merchant1 = create(:merchant, name: 'Mac')
    item1 = create(:item, merchant_id: merchant1.id, unit_price: 400)
    invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, unit_price: 400, quantity: 1)
    create(:transaction, invoice_id: invoice1.id, result: 'success')
    invoice2 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    create(:invoice_item, item_id: item1.id, invoice_id: invoice2.id, unit_price: 400, quantity: 1)
    create(:transaction, invoice_id: invoice2.id, result: 'success')
    invoice3 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
    create(:invoice_item, item_id: item1.id, invoice_id: invoice3.id, unit_price: 400, quantity: 2)
    create(:transaction, invoice_id: invoice3.id, result: 'success')

    merchant2 = create(:merchant, name: 'Lisa')
    item2 = create(:item, merchant_id: merchant2.id, unit_price: 100)
    invoice4 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)
    create(:invoice_item, item_id: item2.id, invoice_id: invoice4.id, unit_price: 100, quantity: 5)
    create(:transaction, invoice_id: invoice4.id, result: 'success')
    invoice5 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)
    create(:invoice_item, item_id: item2.id, invoice_id: invoice5.id, unit_price: 100, quantity: 5)
    create(:transaction, invoice_id: invoice5.id, result: 'success')
    invoice6 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)
    create(:invoice_item, item_id: item2.id, invoice_id: invoice6.id, unit_price: 100, quantity: 1)
    create(:transaction, invoice_id: invoice6.id, result: 'failed')

    merchant3 = create(:merchant, name: 'Kalhune')
    item3 = create(:item, merchant_id: merchant3.id, unit_price: 300)
    invoice7 = create(:invoice, merchant_id: merchant3.id, customer_id: customer.id)
    create(:invoice_item, item_id: item3.id, invoice_id: invoice7.id, unit_price: 300, quantity: 3)
    create(:transaction, invoice_id: invoice7.id, result: 'success')
    invoice8 = create(:invoice, merchant_id: merchant3.id, customer_id: customer.id)
    create(:invoice_item, item_id: item3.id, invoice_id: invoice8.id, unit_price: 300, quantity: 3)
    create(:transaction, invoice_id: invoice8.id, result: 'success')
    invoice9 = create(:invoice, merchant_id: merchant3.id, customer_id: customer.id)
    create(:invoice_item, item_id: item3.id, invoice_id: invoice9.id, unit_price: 300, quantity: 10)
    create(:transaction, invoice_id: invoice9.id, result: 'failed')

    merchant4 = create(:merchant, name: 'Rodney')
    item4 = create(:item, merchant_id: merchant4.id, unit_price: 500)
    invoice10 = create(:invoice, merchant_id: merchant4.id, customer_id: customer.id)
    create(:invoice_item, item_id: item4.id, invoice_id: invoice10.id, unit_price: 500, quantity: 2)
    create(:transaction, invoice_id: invoice10.id, result: 'success')
    invoice11 = create(:invoice, merchant_id: merchant4.id, customer_id: customer.id)
    create(:invoice_item, item_id: item4.id, invoice_id: invoice11.id, unit_price: 500, quantity: 3)
    create(:transaction, invoice_id: invoice11.id, result: 'success')
    invoice12 = create(:invoice, merchant_id: merchant4.id, customer_id: customer.id)
    create(:invoice_item, item_id: item4.id, invoice_id: invoice12.id, unit_price: 500, quantity: 4)
    create(:transaction, invoice_id: invoice12.id, result: 'failed')

    merchant5 = create(:merchant, name: 'Cisco')
    item5 = create(:item, merchant_id: merchant5.id, unit_price: 200)
    invoice13 = create(:invoice, merchant_id: merchant5.id, customer_id: customer.id)
    create(:invoice_item, item_id: item5.id, invoice_id: invoice13.id, unit_price: 200, quantity: 6)
    create(:transaction, invoice_id: invoice13.id, result: 'success')
    invoice14 = create(:invoice, merchant_id: merchant5.id, customer_id: customer.id)
    create(:invoice_item, item_id: item5.id, invoice_id: invoice14.id, unit_price: 200, quantity: 8)
    create(:transaction, invoice_id: invoice14.id, result: 'success')
    invoice15 = create(:invoice, merchant_id: merchant5.id, customer_id: customer.id)
    create(:invoice_item, item_id: item5.id, invoice_id: invoice15.id, unit_price: 200, quantity: 1)
    create(:transaction, invoice_id: invoice15.id, result: 'failed')

  end
  it 'can return a list of certain number of merchants who made the most revenue' do
    get '/api/v1/merchants/most_revenue?quantity=2'

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data'].length).to eql(2)
    expect(json['data'][0]['attributes']['name']).to eql('Cisco')
    expect(json['data'][1]['attributes']['name']).to eql('Rodney')

    get '/api/v1/merchants/most_revenue?quantity=3'

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data'].length).to eql(3)
    expect(json['data'][0]['attributes']['name']).to eql('Cisco')
    expect(json['data'][1]['attributes']['name']).to eql('Rodney')
    expect(json['data'][2]['attributes']['name']).to eql('Kalhune')
  end
end
