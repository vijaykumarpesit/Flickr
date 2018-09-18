1.FLPhotoDisplayViewModel --- Functionality of this view model has been divided in to individual responsibility owners like datasource.This helps to build more reusable components and keeping view model lighter. Clean code architecture where each component will handle one responsibility.  

2.Followed protocol oriented programming for Data and business layer like FLPhotoDataSourceProtocol, FLPhotoDisplayViewModelProtocol.

Nice to have:
1.More test coverage and UI test cases  

2.Use mapping and validator for json parsing instead of heavily depending on Codable protocol.

3.Space between the words in search text -- This has been handled through URL encoding of query params. For some reason not getting results from flickr API, Need to debug.
