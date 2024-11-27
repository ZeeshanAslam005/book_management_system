module API
  module V1
    class BookStore < Grape::API
      before { current_user } # Ensures authentication

      resource :bookstores do
        desc 'Get all bookstores'
        get do
          bookstores = ::Bookstore.all
          bookstores.map do |bookstore|
            {
              id: bookstore.id,
              name: bookstore.name,
              location: bookstore.location,
              books_count: bookstore.books.count
            }
          end
        end

        desc 'Get a single bookstore'
        params do
          requires :id, type: Integer, desc: 'Bookstore ID'
        end
        get ':id' do
          bookstore = ::Bookstore.find(params[:id])
          {
            id: bookstore.id,
            name: bookstore.name,
            location: bookstore.location,
            books: bookstore.books.map do |book|
              {
                id: book.id,
                title: book.title,
                author: book.author,
                price: book.price
              }
            end
          }
        end
      end
    end
  end
end
