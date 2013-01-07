Fakebook API
=====================

### About
Fakebook-API is a project designed to act as a wrapper for API calls to the Facebook social networking site. Fakebook-API provides a DSL to give you canned results such as a fake friend list. Fakebook-API in no way ever communites with facebook and does not require you to even have a facebook application registered. Instead it uses Webmock to mock out all calls to the facebook API giving you canned responses. This mocking allows you to use Koala or any other gems to connect to facebook in the same way that you would in your project allowing good end to end testing.

### Development Status
Breaking News: It looks like facebook have chagned their documentation. Currently there is no way to pull down a sample document from their doc site. This whole gem was built around being able to scrape their doc and build the requests from the scraper. While this is still possible it would require more work to write a parser for their doc. That's providing they don't chagne it again.  If anyone has an idea on how this is best done I would love to hear it

### Useage
Fakebook-API is great for simulating expensive operations performed on facebook's GraphAPI. It's also good for arbitrary testing that requires X amount of users. Fakebook-API's current goals do not involve being a one stop solution for testing however we would love patches that extend the graph API end points we are supporting.

Fakeing with Fakebook is done via the DSL. The following will tell fakebook-api to simulate 5000 friends for us.
```ruby
FakebookAPI.fake
  friends 5000
end
```
Fakebook maps directly to objects on the graph. Any object on the graph has an object in fakebook-api.

To interact with Facebook you can use Koala or even net/http...(seriously though use Koala). To perform operations you will need an access_token. Fakebook-API will provide you with one that it precooks so you never have to worry about auth.

```ruby
#using Koala
@graph = Koala::Facebook::API.new(FakebookAPI.access_token)
@graph.get_connections("me", "friends") # <= Returns 5000 friends
```
