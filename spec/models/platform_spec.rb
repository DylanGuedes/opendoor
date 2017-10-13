require 'rails_helper'

RSpec.describe Platform, type: :model do
  describe "invalid params" do
    it "requires a url" do
      attrs = FactoryGirl.attributes_for(:platform, url: nil)
      aq = Platform.new(attrs)
      expect(aq).not_to be_valid
    end
  end

  describe "valid params" do
    it "works well" do
      attrs = FactoryGirl.attributes_for(:platform)
      platform = Platform.new(attrs)
      expect(platform).to be_valid
    end
  end
end
