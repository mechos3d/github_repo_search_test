# github_repo_search_test

The project allows searching public Github repositories.         
[Example of this app running on Heroku](https://gorg-repo-search.herokuapp.com/repositories)
(it's 'sleeping' on a free dyno, so the first cold start will be slow)

To authenticate calls to github-api the application needs a personal access token (you can generate one in your [github account settings](https://github.com/settings/tokens)).         
Please provide it in an ENV-variable GITLAB_AUTH_TOKEN      
(or in /config/settings.local.yml for local development)         

Running locally (using Docker):
```
docker build -t github_repo_search_test .
docker run -p 3000:3000 github_repo_search_test:latest
```

----

## TODOS:

- If we encounter and handle some errors - the page is rendered with a 200 "OK" status. But in some cases maybe better to render the page with 4xx status.
- In case of a request timeout - Faraday will raise an exception. Need to rescue it and show some reasonable message to the user.
- UI/UX: add better pagination with a list of numbers denoting pages, 'next' and 'previous', 'first', 'last' buttons (using Kaminari for example).
- Fix exception for too big page request: `/repositories?query=foo&sort=&order=desc&page=1000000000`
- URI::InvalidURIError - some characters will raise this exception - need to sanitize the user's input. 
- More Rspec-tests on edge-cases.
- Try a variant with refreshing repositories list by Ajax call (SPA approach).
- Validate on the backend that order and sort are among valid values, accepted by github api.
- Cut the repositories description to some reasonable length. Sometimes it can be quite long: https://github.com/DeoAniner/WasHere (on github page it's shortened already, in reality it's about 20k characters long)        
- Add instructions about query language on the page with a link to GitHub docs: https://developer.github.com/v3/search/#constructing-a-search-query
- Return an error by the Formatter class instead of exception if, for some reason, Github returned an invalid JSON.        
- Fix the error 'ActionView::Template::Error: The asset "foo4" is not present in the asset pipeline.' when avatar url is invalid (not a url).     
- All the UI texts must use I18n
- UI/UX: add a note for the user - what the default sorting order is.
- UI/UX: show on the page more info in the list of repos: number of stars, issues, forks etc.
- UI/UX: show on the page more info in the list of repos: number of stars, issues, forks etc.
- Add an option to change the number of items shown on the page.

----

## NOTES:
- I chose not to implement SPA here (I'm not using Ajax to refresh the list of repos).
  I'm convinced that the main functionality of the site, whenever possible, should not rely on javascript being enabled.        
  Maybe I'm a bit conservative like that :) 

