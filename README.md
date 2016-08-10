## Introduction

This app is a hybrid of [meetup.com](meetup.com) and [Eventbrite](eventbrite.com)

## Explore the app

https://evening-badlands-3166.herokuapp.com/

## Configuration

* Download or clone the repo
* [Create a Postgres role for the database](https://www.digitalocean.com/community/tutorials/how-to-setup-ruby-on-rails-with-postgres)
* Run `bundle install`
* Run `rake db:migrate`
* Run `rails server`
* Head over to http://localhost:3000/

## Project goals

* Use a popular API
* Test edge cases with unit tests instead of integration tests
* Cleaner code (with rubocop)
* More complicated than my previous blog project



## Some cool features

* Uses Google Maps Geolocation API
* Converts addresses, zipcodes, cities, and ip addresses to latitude/longitude coordinates
* Has custom search functionality for objects within a radius of lat/long coordinates
* Polymorphic address model
* 12 models and 15 controllers
* Special privileges for group creators and appointed mods
* Invite only groups
* Several nested resources
* 237 specs that run in under 12 seconds

## What I learned

#### Unit tests

Unsatisfied with free tutorials found on the web, I gave in and purchased [Everyday Rails Testing with RSpec](https://leanpub.com/everydayrailsrspec).

I can't recommend this book enough. It clearly explained how to unit test basic REST actions, and I continue to reference it to this day.

With the help of this book I achieved a test suite with 237 specs that would run in under 12 seconds.

I'm still not entirely sure how good that is, but I was pretty satisfied with that result!   

#### Using an external API

In retrospect, using an external API was a mental hurdle. For some reason I felt like it was something only advanced programmers used.

With the help of Google's documentation, and the excellent Geolocation gem's documentation I was able to add the desired functionality with ease.

## Room for improvement

#### Specs touch an external API

For some reason I could not get WebMock and VCR working.

At the time I didn't really consider this too big of a problem. It seemed very strange to me to have an integration test that just returned what you told it to. It didn't feel like testing.

Now I understand the problem. It's ridiculous needing internet to run my specs. Also, in case of a timeout from Google's API, my specs would show a failure even though nothing is wrong on my end.

#### Convoluted process getting a guest's location

This one is embarrassing:

Both eventbrite and meetup.com are very location oriented. What surprised me was that meetup.com somehow knew my location in an incognito window as a guest. So no database lookup from a previously saved location and no cookies.

I wracked my brain for a while trying to figure out how to emulate this feature. I knew that you could get a rough location from an ip address, so I decided to grab the ip address, convert it to a zipcode, and then convert that zipcode into geographical coordinates.

I actually thought, and still somewhat feel that this was a clever solution. But I think that this solution highlighted my abysmal understanding of javascript. Instead of just using javascript's geolocation feature to get the coordinates, I created this over-engineered solution.

In my defense, meetup.com never asks for permission to get coordinates, which leads me to believe that they used a solution similar to mine. But that doesn't change the fact that I would have used javascript to complete this task had I known about that feature.

## License

The MIT License (MIT)
Copyright (c) 2016 Paul Johnston

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
