module API
  module V1
    module BookStores
      class Show < Grape::API

        desc 'Get a single bookstore'
        params do
          requires :id, type: Integer, desc: 'Bookstore ID'
        end
        
        get ':id' do
          bookstore = ::Bookstore.find(params[:id])
          authorize!(bookstore, :show?)
          
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
