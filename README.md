# San Diego Apartments
Gathers data on available San Diego apartments and alerts subscribers to changes

## Screenshots

### Web
![web screenshot](https://cloud.githubusercontent.com/assets/7942714/16213460/96b420da-371d-11e6-97d7-d04769614e2c.png)

### Email alert
![email alert screenshot](https://cloud.githubusercontent.com/assets/7942714/16213464/984fb594-371d-11e6-8760-9dac12500634.png)

## Demo
Try it out for yourself at [http://sandiego.nickholden.io](http://sandiego.nickholden.io)

## Installation

```
git clone git://github.com/nholden/san-diego-apartments
cd san-diego-apartments
bundle install

bundle exec rake db:reset
```

## Getting started

```
rails s
```

The app scrapes data from apartment websites using tasks, which you can view at `lib/tasks/scheduler.rake`. Run a task from the command line with  `bundle exec rake [TASK NAME]`. You can also configure a service like Heroku Scheduler to run these tasks at regular intervals.

Email alerts are sent by Mailgun. Sign up for a free account at [mailgun.com](http://www.mailgun.com). Copy `.env.example` to `.env` and fill in your Mailgun credentials.

## Testing

```
bundle exec rake
```

## Credits

This project was created by Nick Holden and is licensed under the terms of the MIT license.
