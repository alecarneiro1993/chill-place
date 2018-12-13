require 'rails_helper'
require 'json'
RSpec.describe 'API Requests', type: :request do

  before(:all) do
    @movie = FactoryBot.create(:movie)
    @season = FactoryBot.create(:season)
    @user = FactoryBot.create(:user)
  end

  it 'GET #movies' do
    get '/api/movies'
    expect(response.status).to eq(200)
  end

  it 'GET #seasons' do
    get '/api/seasons'
    expect(response.status).to eq(200)
  end

  it 'GET #all' do
    get '/api/all'
    expect(response.status).to eq(200)
  end

  it 'POST #create movie' do
    post '/api/purchases', :params => {
      purchase: {
        purchasable_id: @movie.id,
        purchasable_type: @movie.class.to_s,
        user_id: @user.id,
        quality: :standard
      }
    }
    expect(response.status).to eq(200)
  end

  it 'POST #create season' do
    post '/api/purchases', :params => {
      purchase: {
        purchasable_id: @season.id,
        purchasable_type: @season.class.to_s,
        user_id: @user.id,
        quality: :high
      }
    }
    expect(response.status).to eq(200)
  end

  it 'POST #create (block buying already bought item)' do
    post '/api/purchases', :params => {
      purchase: {
        purchasable_id: @season.id,
        purchasable_type: @season.class.to_s,
        user_id: @user.id,
        quality: :high
      }
    }
    expect(response.status).to eq(200)

    post '/api/purchases', :params => {
      purchase: {
        purchasable_id: @season.id,
        purchasable_type: @season.class.to_s,
        user_id: @user.id,
        quality: :high
      }
    }
    expect(response.status).to eq(401)
  end

  it 'GET #index' do
    50.times { FactoryBot.create(:purchase, user_id: @user.id) }
    get '/api/purchases', :params => { id: @user.id }
    body = JSON.parse(response.body)
    expect(body['purchased_items'].size).to eq(50)
  end

end
