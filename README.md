1.FLPhotoDisplayViewModel --- Functionality of this view model is divided in to individual responsibility owners like datasource to avoid viewmodel is getting heavier and to come up with resuable components like data source.

2.Followed protocol oriented programming for Data and business layer like data source, FLPhotoDisplayViewModel

Nice to have:
1.More test coverage and UI test cases  

2.Use mapping and validator for json parsing instead of heavily depending on codable protocol.

3.Space between the words in search text -- This has been handled through URL encoding of query params. For some reason not getting results from flickr API, Need to debug.
