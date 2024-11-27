User.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  role: 'admin'
)

user = User.create!(
  email: 'customer@example.com',
  password: 'password',
  password_confirmation: 'password',
  role: 'customer'
)

# Create a bookstore
bookstore = Bookstore.create!(name: 'Central Bookstore', location: 'Main Street')

# Create some books
book1 = bookstore.books.create!(title: 'Ruby Basics', author: 'John Doe', price: 25.50)
book2 = bookstore.books.create!(title: 'Advanced Rails', author: 'Jane Smith', price: 40.00)

# Create an order
Order.create!(user: user, book: book1, quantity: 2)
Order.create!(user: user, book: book2, quantity: 1)
