module API
  module V1
    module BookStores
      class Index < Grape::API
        before { authorize!(::Bookstore, :index?) }

        desc 'Get all bookstores'
        get do
          bookstores = policy_scope(::Bookstore)
          bookstores.map do |bookstore|
            {
              id: bookstore.id,
              name: bookstore.name,
              location: bookstore.location
            }
          end
        end
      end
    end
  end
end
