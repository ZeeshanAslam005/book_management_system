module API
  module V1
    module BookStores
      class Index < Grape::API
        desc 'Get all bookstores'
        get do
          ::Bookstore.all.map do |bookstore|
            {
              id: bookstore.id,
              name: bookstore.name,
              location: bookstore.location,
              books_count: bookstore.books.count
            }
          end
        end
      end
    end
  end
end
