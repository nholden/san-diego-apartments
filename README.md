# San Diego Apartments
Gathers data on available San Diego apartments and alerts subscribers to changes.

## Screenshots

![screenshot](https://cloud.githubusercontent.com/assets/7942714/16229957/2a4a8a36-378d-11e6-8f0e-dea6dbd069cd.png)

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

The app scrapes data from apartment websites using tasks, which you can view at [`lib/tasks/scheduler.rake`](https://github.com/nholden/san-diego-apartments/blob/master/lib/tasks/scheduler.rake). Run a task from the command line with  `bundle exec rake [TASK NAME]`. You can also configure a service like [Heroku Scheduler](https://elements.heroku.com/addons/scheduler) to run these tasks at regular intervals.

Email alerts are sent by Mailgun. Sign up for a free account at [mailgun.com](http://www.mailgun.com). Copy [`.env.example`](https://github.com/nholden/san-diego-apartments/blob/master/.env.example) to `.env` and fill in your Mailgun credentials.

## Testing

```
bundle exec rake
```

## Credits

This project was created by Nick Holden and is licensed under the terms of the MIT license.
