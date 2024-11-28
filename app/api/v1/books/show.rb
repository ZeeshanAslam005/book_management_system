module API
  module V1
    module Books
      class Show < Grape::API
        before { current_user }

        desc 'Get a single book'
        params do
          requires :id, type: Integer, desc: 'Book ID'
        end
        get ':id' do
          book = ::Book.find(params[:id])
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
