# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Category.destroy_all
Fiction.destroy_all
Review.destroy_all


users = User.create!([
    {
        email: 'test@test.com',
        username: 'test01',
        password: '000000',
        bio: "I'm Tester"
    },
    {
        email: 'aeka@email.com',
        username: 'test02',
        password: '000000',
        bio: "I'm Tester"
    },
    {
        email: 'onemanshow@email.com',
        username: 'onemansky',
        password: '123456',
        bio: "No One Know Me"
    }
])

categories = Category.create!([
    {
        name: "Fantasy"
    },
    {
        name: "Epic"
    },
    {
        name: "Romance"
    },
    {
        name: "Crime"
    },
    {
        name: "Science"
    },
    {
        name: "Horror"
    }
])

(1..10).to_a.each do |i|
    Fiction.create!([
        name: "Fiction Name #{i}",
        description: "description test",
        article: "Ep #{i}",
        image_url: "https://images.unsplash.com/photo-1432958576632-8a39f6b97dc7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1052&q=80",
        user_id: User.first.id,
        category_id: Category.first.id
    ])
end

(1..5).to_a.each do |i|
    Fiction.create!([
        name: "Epic Name #{i}",
        description: "description test",
        article: "Ep #{i}",
        image_url: "https://images.unsplash.com/photo-1534447677768-be436bb09401?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1071&q=80",
        user_id: User.second.id,
        category_id: Category.second.id
    ])
end

reviews = Review.create!([
    title: "Hello Title",
    description: "Not Bad",
    score: "4",
    user_id: User.last.id,
    fiction_id: Fiction.last.id
])

reviews = Review.create!([
    title: "Hello Title",
    description: "Not Bad",
    score: "2",
    user_id: User.last.id,
    fiction_id: Fiction.first.id
])
