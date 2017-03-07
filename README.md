# Slackbot::Rails

An activerecord hook to send notifications to slack on updations and creation of resources.

## Installation

Add this line to your application's Gemfile:

    gem 'slackbot-rails', :git => 'git://github.com/bitsapien/slackbot-rails.git'

And then execute:

    $ bundle

## Usage

Just put the `notify_bot` method in your model

```ruby
class Model < ActiveRecord::Base
  notify_bot bot:     {
               webhook: '<WEBHOOK URL>',
               name: '<BOT NAME>',
               channel: '#channel-name'
             }, 
             message: {
              create: 'A new resource in *{class.model_name.human}* was created. '}

end
```

This would send a notification on Slack:

![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)


#### Setting Defaults

You may enable/disable notifications using a flag, for example in `application.rb`

```ruby
config.slackbot_rails_enable = Rails.env.production?
```


## TODO

1. Specs!
2. Background job option.
3. Add I18n support.
4. Add fallbacks for configurations.
5. Add more support for emojis.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
