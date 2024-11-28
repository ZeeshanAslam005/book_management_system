module API
  module V1
    module Books
      class Index < Grape::API
        before { authorize!(::Book, :index?) }

        desc 'Get all books'
        get do
          books = policy_scope(::Book)
          books.map do |book|
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
