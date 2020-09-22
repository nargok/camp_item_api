require 'rails_helper'

RSpec.describe "Items", type: :request do
  it 'get all items' do
    FactoryBot.create_list(:item, 10)

    get '/api/v1/items'
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json['data'].length).to eq(10)
  end

  it 'get single item', type: :request do
    item = FactoryBot.create(:item, name: 'テント')

    get "/api/v1/items/#{item.id}"
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json['data']['name']).to eq(item.name)
  end

  it 'create a new item', type: :request do
    valid_params = { name: 'new item', price: 20000, description: 'memo' }

    expect { post '/api/v1/items', params: { item: valid_params } }.to change(Item, :count).by(+1)
    expect(response.status).to eq(200)
  end

  it 'update item', type: :request do
    item = FactoryBot.create(:item)

    put "/api/v1/items/#{item.id}", params: { item: { name: 'udpated item' }}
    json = JSON.parse(response.body)
    
    expect(response.status).to eq(200)

    expect(json['data']['name']).to eq('udpated item')
  end

  it 'delete item', type: :request do
    item = FactoryBot.create(:item)

    expect { delete "/api/v1/items/#{item.id}"}.to change(Item, :count).by(-1)
    expect(response.status).to eq(200)
  end
end
