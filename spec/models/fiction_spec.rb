require 'rails_helper'

RSpec.describe Fiction, type: :model do
    it "shouldn't create with out everything" do
      fictions = Fiction.new
      expect(fictions).to_not be_valid
  end

    it "shouldn't create with out description" do
      user = User.create(email: 'test@test.com',username: 'test01', password: '000000',bio: "I'm Tester")
      cat = Category.create(name: "Fantasy")
      fictions = Fiction.new(user_id: user.id, category_id: cat.id, name: "Test", article: "Test")
      fictions2 = Fiction.new(user_id: user.id, category_id: cat.id, name: "Test2", article: "Test2")
        expect(fictions).to_not be_valid
        expect(fictions2).to_not be_valid
    end

    it "shouldn't create with out article" do
      user = User.create(email: 'test@test.com',username: 'test01', password: '000000',bio: "I'm Tester")
      cat = Category.create(name: "Fantasy")
      fictions = Fiction.new(user_id: user.id, category_id: cat.id, name: "test", description: "test")
      expect(fictions).to_not be_valid
    end

    it "should create with everything" do
      user = User.create(email: 'test@test.com',username: 'test01', password: '000000',bio: "I'm Tester")
      cat = Category.create(name: "Fantasy")
      fictions = Fiction.new(user_id: user.id, category_id: cat.id, name: "test", description: "test", article: "test")
      expect(fictions).to be_valid
    end
end
