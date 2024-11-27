# app/api/v1/book.rb
module API
  module V1
    class Books < Grape::API
      before { current_user } # Ensures token-based authentication

      resource :books do
        desc 'Get all books'
        get do
          ::Book.all.map do |book| # Fully qualified to avoid namespace conflict
            {
              id: book.id,
              title: book.title,
              author: book.author,
              price: book.price,
              bookstore: {
                id: book.bookstore.id,
                name: book.bookstore.name
              }
            }
          end
        end

        desc 'Get a single book'
        params do
          requires :id, type: Integer, desc: 'Book ID'
        end
        get ':id' do
          book = ::Book.find(params[:id]) # Fully qualified Book model
          {
            id: book.id,
            title: book.title,
            author: book.author,
            price: book.price,
            bookstore: {
              id: book.bookstore.id,
              name: book.bookstore.name
            }
          }
        end
      end
    end
  end
end
