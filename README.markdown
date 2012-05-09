Fakebook API
=====================

### About
Fakebook-API is a project designed to act as a wrapper for API calls to the Facebook social networking site. Fakebook-API provides a DSL to give you canned results such as a fake friend list. Fakebook-API in no way ever communites with facebook and does not require you to even have a facebook application registered. Instead it uses Webmock to mock out all calls to the facebook API giving you canned responses. This mocking allows you to use Koala or any other gems to connect to facebook in the same way that you would in your project allowing good end to end testing.

### Useage
Fakebook-API is great for simulating expensive operations performed on facebook's GraphAPI. It's also good for arbitrary testing that requires X amount of users. Fakebook-API's current goals do not involve being a one stop solution for testing however we would love patches that extend the graph API end points we are supporting.


To create 5000 random friends to be returned use the following command.
```ruby
FakebookAPI::Friends.create(5000)
```

To get these friends you might be using Koala or even net/http...(seriously though use Koala). To perform operations you will need an access_token. Fakebook-API will provide you with one that it precooks so you never have to worry about auth.

```ruby
FakebookAPI.access_token
```
