# Clear existing data to avoid duplicates during reseeding
User.destroy_all
Bookstore.destroy_all
Book.destroy_all
Order.destroy_all

# Create Users
admin = User.create!(email: 'admin@example.com', password: 'password', role: 'admin')
manager1 = User.create!(email: 'manager1@example.com', password: 'password', role: 'manager')
manager2 = User.create!(email: 'manager2@example.com', password: 'password', role: 'manager')
customer1 = User.create!(email: 'customer1@example.com', password: 'password', role: 'customer')
customer2 = User.create!(email: 'customer2@example.com', password: 'password', role: 'customer')

puts "Created Users: #{User.count}"

# Create Bookstores
bookstore1 = Bookstore.create!(name: 'City Books', location: 'Downtown', manager_id: manager1.id)
bookstore2 = Bookstore.create!(name: 'Readers Paradise', location: 'Uptown', manager_id: manager2.id)

puts "Created Bookstores: #{Bookstore.count}"

# Create Books
books = []
10.times do |i|
  books << Book.create!(
    title: "Book #{i + 1}",
    author: "Author #{i + 1}",
    price: rand(10..50),
    bookstore_id: [bookstore1.id, bookstore2.id].sample,
    published_date: Date.today - rand(1000..5000)
  )
end

puts "Created Books: #{Book.count}"

# Create Orders
orders = []
5.times do
  orders << Order.create!(
    user_id: customer1.id,
    book_id: books.sample.id,
    quantity: rand(1..5),
    total_price: books.sample.price * rand(1..5)
  )
end

5.times do
  orders << Order.create!(
    user_id: customer2.id,
    book_id: books.sample.id,
    quantity: rand(1..5),
    total_price: books.sample.price * rand(1..5)
  )
end

puts "Created Orders: #{Order.count}"

# Output summary
puts "Seeding complete!"
