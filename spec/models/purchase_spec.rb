require 'rails_helper'

RSpec.describe Purchase, type: :model do

  before(:all) do
    @movie = FactoryBot.create(:movie)
    @season = FactoryBot.create(:season)
    @user = User.any? ? User.first : FactoryBot.create(:user)
  end

  context 'a movie with' do
    it "SD quality" do
      subject.user = @user
      subject.purchasable = @movie
      subject.quality = :standard
      expect(subject).to be_valid
      expect{ subject.save }.not_to raise_error
    end

    it "HD quality" do
      subject.user = @user
      subject.purchasable = @movie
      subject.quality = :high
      expect(subject).to be_valid
      expect{ subject.save }.not_to raise_error
    end
  end

  context 'a season with' do
    it "SD quality" do
      subject.user = @user
      subject.purchasable = @season
      subject.quality = :standard
      expect(subject).to be_valid
      expect{ subject.save }.not_to raise_error
    end

    it "HD quality" do
      subject.user = @user
      subject.purchasable = @season
      subject.quality = :high
      expect(subject).to be_valid
      expect{ subject.save }.not_to raise_error
    end
  end
end
