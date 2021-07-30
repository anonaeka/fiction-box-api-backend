require 'rails_helper'

RSpec.describe Review, type: :model do
  it "shouldn't create with out everything" do
      reviews = Review.new
      expect(reviews).to_not be_valid
  end

  it "shouldn't create with out user_id" do
    user = User.create(email: 'userreview@review.com',username: 'view0101', password: 'view0101',bio: "I'm Tester")
    cat = Category.create(name: "dodo")
    fic = Fiction.create(name: "test1", description: "test1", article: "test1", category_id: cat.id, user_id: user.id)
    reviews = Review.new(title: "Gone", description: "Des", score: 3.0, fiction_id: fic.id)
    expect(reviews).to_not be_valid
  end

  it "shouldn't create with out fiction_id" do
    user = User.create(email: 'userreview@review.com',username: 'view0101', password: 'view0101',bio: "I'm Tester")
    reviews = Review.new(title: "Gone", description: "Des", user_id: user.id)
    expect(reviews).to_not be_valid
  end

  it "shouldn't create with out score" do
    user = User.create(email: 'userreview@review.com',username: 'view0101', password: 'view0101',bio: "I'm Tester")
    cat = Category.create(name: "dodo")
    fic = Fiction.create(name: "test1", description: "test1", article: "test1", category_id: cat.id, user_id: user.id)
    reviews = Review.new(title: "Gone", description: "Des", user_id: user.id, fiction_id: fic.id)
    expect(reviews).to_not be_valid
  end

  it "should create with everything" do
    user = User.create(email: 'userreview@review.com',username: 'view0101', password: 'view0101',bio: "I'm Tester")
    cat = Category.create(name: "dodo")
    fic = Fiction.create(name: "test1", description: "test1", article: "test1", category_id: cat.id, user_id: user.id)
    reviews = Review.new(title: "Gone", description: "Des", score: 3.0, user_id: user.id, fiction_id: fic.id)
    expect(reviews).to be_valid
  end
end
