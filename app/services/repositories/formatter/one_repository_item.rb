module Repositories
  class Formatter
    class OneRepositoryItem
      def call(item)
        result = item.slice('full_name', 'html_url', 'description')
        result['avatar_url'] = element['owner']['avatar_url']
      end
    end
  end
end
