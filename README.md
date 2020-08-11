[![Build Status](https://travis-ci.org/teepha/events-api.svg?branch=develop)](https://travis-ci.org/teepha/events-api)
[![Coverage Status](https://coveralls.io/repos/github/teepha/events-api/badge.svg?branch=develop)](https://coveralls.io/github/teepha/events-api?branch=develop)
[![Maintainability](https://api.codeclimate.com/v1/badges/63daf80b4f341c1fa1f4/maintainability)](https://codeclimate.com/github/teepha/events-api/maintainability)

# Events-API
## Introduction
An event ticketing platform that allow users to create events and go live (selling paid or free tickets) in under five minutes.

## Table of Contents
1. <a href="#hosted-app">Link to Hosted App</a>
2. <a href="#stack-used">Tech Stack Used</a>
3. <a href="#application-features">Application Features</a>
4. <a href="#how-to-use">How To Use</a>
5. <a href="#contributing">Contributing</a>
6. <a href="#author">Author</a>
7. <a href="#license">License</a>


## Link to Hosted App
* [API link](https://teepha-events-api.herokuapp.com)

## Tech Stack Used

- [Ruby](https://rubygems.org/) | Version: 2.7.0
- [Rails](https://rubyonrails.org/) | Version: 6.0.3
- [Postgresql](https://www.postgresql.org/)

## Application Features

* Register a user
* User login
* User can update their profile
* User can fetch their profile
* Admin can fetch user profile
* Admin can fetch all users
* User can create an event
* User can update an event
* User can get a single event
* User can delete an event
* Admin can get a single event
* User/Admin can fetch all events
* User/Admin can fetch all active events
* User can generate invitation url for an event
* User can view another user's event with the invitation url

## How To Use

To clone and run this application, you'll need [Git](https://git-scm.com), [Ruby](https://rubygems.org/) and [Rails](https://rubyonrails.org/) installed on your computer. From your command line:

```bash
# Clone this repository
$ git clone https://github.com/teepha/events-api.git

# Go into the repository
$ cd events-api

# Install dependencies
$ bundle install

# Create application.yml file for environmental variables in the config folder in your root directory like the application.yml.sample file and provide the keys

# Create the db
$ rails db:create

# Run migration
$ rails db:migrate

# Start the app
$ rails s

# Check the port on the specified port on the env or 3000

# Run test
$ rails test
```

## API endpoints

Base_URL -> ```localhost:3000```
  * Register: 
  ```
  {
    path: '/signup',
    method: POST,
    body: {
      first_name: <string>,
      last_name: <string>,
      email: <string, unique>,
      password: <string>,
    }
  }
  ```
  * Login: 
  ```
  {
    path: '/login',
    method: POST,
    body: {
      email: <string, unique>,
      password: <string>
    }
  }
  ```
  * User can update their profile: 
  ```
  {
    path: '/users/<user_id>',
    method: PUT,
    header: Authorization<token>,
    params: {
      user_id: <integer>,
    },
    body: {
      first_name: <string>,
      last_name: <string>,
      email: <string, unique>,
      password: <string>,
    }
  }
  ```
  * User can fetch their profile: 
  ```
  {
    path: '/users/<user_id>',
    method: GET,
    header: Authorization<token>,
    params: {
      user_id: <integer>,
    }
  }
  ```
  * Admin can fetch user profile: 
  ```
  {
    path: '/users/<user_id>',
    method: GET,
    header: Authorization<token: admin>,
    params: {
      user_id: <integer>,
    }
  }
  ```
  * Admin can fetch all users: 
  ```
  {
    path: '/users',
    method: GET,
    header: Authorization<token: admin>,
  }
  ```
  * User can create an event: 
  ```
  {
    path: '/events',
    method: POST,
    header: Authorization<token>,
    body: {
      name: <string>,
      description: <integer>,
      venue: <string>,
      is_free: <boolean>,
      gate_fee: <integer>,
      start_time: <datetime>,
      end_time: <datetime>
    }
  }
  ```
  * User can update an event: 
  ```
  {
    path: '/events/<event_id>',
    method: PUT,
    header: Authorization<token>,
    params: {
      event_id: <integer>,
    },
    body: {
      name: <string>,
      description: <integer>,
      venue: <string>,
      is_free: <boolean>,
      gate_fee: <integer>,
      start_time: <datetime>,
      end_time: <datetime>,
      is_active: <boolean>
    }
  }
  ```
  * User can get a single event: 
  ```
  {
    path: '/events/<event_id>',
    method: GET,
    header: Authorization<token>,
    params: {
      event_id: <integer>,
    }
  }
  ```
  * User can delete an event: 
  ```
  {
    path: '/events/<event_id>',
    method: DELETE,
    header: Authorization<token>,
    params: {
      event_id: <integer>,
    }
  }
  ```
  * User can can fetch all their events: 
  ```
  {
    path: '/events',
    method: GET,
    header: Authorization<token>,
  }
  ```
  * User can can fetch all their active events: 
  ```
  {
    path: '/events/active',
    method: GET,
    header: Authorization<token>,
  }
  ```
  * Admin can get a single event: 
  ```
  {
    path: '/events/<event_id>',
    method: GET,
    header: Authorization<token: admin>,
    params: {
      event_id: <integer>,
    }
  }
  ```
  * Admin can fetch all events: 
  ```
  {
    path: '/events',
    method: GET,
    header: Authorization<token: admin>
  }
  ```
  * Admin can fetch all active events: 
  ```
  {
    path: '/events/active',
    method: GET,
    header: Authorization<token: admin>
  }
  ```
  * User can generate invitation url for an event: 
  ```
  {
    path: '/events/<event_id>/url',
    method: GET,
    header: Authorization<token>,
    params: {
      event_id: <integer>
    }
  }
  ```
  * User can view another user's event with the invitation url: 
  ```
  {
    path: '/events/<event_id>/invitation',
    method: GET,
    header: Authorization<token>,
    params: {
      event_id: <integer>
    }
  }
  ```

## Contributing
* Fork it: [Fork the Events-API project](https://github.com/teepha/events-api/fork)
* Create your feature branch (`git checkout -b my-new-feature`)
* Commit your changes (`git commit -am 'Add some feature'`)
* Push to the branch (`git push origin my-new-feature`)
* Create a new Pull Request

## Author

Lateefat Amuda

## License

MIT

---