require 'rails_helper'

RSpec.describe Category, type: :model do
    it "shouldn't create with out everything" do
      category = Category.new
      expect(category).to_not be_valid
  end
    it "should create with everything" do
      category = Category.new(name: "FOO!!")
      expect(category).to be_valid
    end
end
