# frozen_string_literal: true

module Github
  class Client
    AUTHORIZATION = Settings.github.client.authorization
    BASE_URL = 'https://api.github.com/'
  end
end
