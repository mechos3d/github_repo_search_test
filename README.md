# github_repo_search_test


## TODOS:

- Set explicit reasonable timeouts to Faraday request.
- Now if we encounter and handle some errors - the page is rendered with a 200 "OK" status. Better to render it with correct statuses (4xx/5xx).
- Maybe try option with refreshing repositories list by Ajax call (SPA).
- Fix exception for too big page request: /repositories?query=foo&sort=&order=desc&page=1000000000
- URI::InvalidURIError - some characters will raise this exeption - need to sanitize / validate user's input 
- More Rspec-tests on edge-cases.
- Validate on backend that order and sort are among valid values, accepted by github api
- Cut the repositories description to some reasonable lehgth. Sometimes it can be quite long: https://github.com/DeoAniner/WasHere (on github page it's shortened already, in reallity it's about 20k characters long  )
- Add instuctions about query language on the page with a link to GitHub docs: https://developer.github.com/v3/search/#constructing-a-search-query
- Return an error by the Formatter class instead of exception if, for some reason, Github returned an invalid JSON.
- Fix the error 'ActionView::Template::Error: The asset "foo4" is not present in the asset pipeline.' when avatar url is invalid (not a url)
- All the UI texts must use I18n
- UI: add a note for the user - what the default sorting order is.
- UI: show on the page more info in the list of repos: number of stars, issues, forks etc.
- Add an option to change number of items shown on page.

