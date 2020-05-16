# github_repo_search_test


## TODOS:

- Fix exception for too big page request: http://localhost:3000/repositories?query=bunny&sort=&order=desc&page=1000000000&commit=Search
- URI::InvalidURIError - some characters will raise this exeption - need to sanitize / or validate user's input 
- Show different error messages to the user depending on the http-status of github response.
- Show user-avatars for repos
- Rspec-tests on edge-cases
- Add instuctions about query language on the page with a link to GitHub docs: https://developer.github.com/v3/search/#constructing-a-search-query
- remove 'q=' from the start if user entered it
- Rerfresh repositories list ushing Ajax 

