module API
  module V1
    module Books
      class Index < Grape::API
        before { current_user }

        desc 'Get all books'
        get do
          ::Book.all.map do |book|
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
end
