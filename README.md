# github_repo_search_test


## TODOS:

- Now if we encounter some errors that we processed - the page is rendered with a 200 "OK" status. Better to render it with correct statuses (4xx/5xx)
- Set explicit reasonable timeouts to Faraday request.
- Fix exception for too big page request: /repositories?query=foo&sort=&order=desc&page=1000000000
- URI::InvalidURIError - some characters will raise this exeption - need to sanitize / validate user's input 
- Rspec-tests on edge-cases
- Rerfresh repositories list ushing Ajax 
- Validate on backend that order and sort are among valid values, accepted by github api
- Cut the repositories description to some reasonable lehgth. Sometimes it can be quite long: https://github.com/DeoAniner/WasHere (on github page it's shortened already, in reallity it's about 20k characters long  )
- Add instuctions about query language on the page with a link to GitHub docs: https://developer.github.com/v3/search/#constructing-a-search-query
- remove 'q=' from the start if user entered it
- Return an error by the Formatter class instead of exception if, for some reason, Github returned an invalid JSON.
- Fix the error 'ActionView::Template::Error: The asset "foo4" is not present in the asset pipeline.' when avatar url is invalid (not a url)
- All the UI texts must use I18n

