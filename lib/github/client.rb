# frozen_string_literal: true

module Github
  class Client
    BASE_URL = 'https://api.github.com/' # TODO: can take this from application settings
    # TODO: definitely need to place them in application global settings and get them fron ENV:
    CREDENTIALS = 'username:api_token'
  end
end
