# frozen_string_literal: true

module Github
  class Client
    BASE_URL = 'https://api.github.com/' # TODO: can take this from application settings

    # TODO: Although 'Settings' (gem 'config') supports ERB in it -
    # for some reason it cannot get ENV-variables here, hence this crutch:
    AUTHORIZATION = Settings.github.client.authorization || ENV.fetch('GITHUB_AUTHORIZATION')
  end
end
