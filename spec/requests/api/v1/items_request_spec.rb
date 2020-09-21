require 'rails_helper'

RSpec.describe "Items", type: :request do
  it 'get all items' do
    FactoryBot.create_list(:item, 10)

    get '/api/v1/items'
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)

    expect(json['data'].length).to eq(10)
  end


end
