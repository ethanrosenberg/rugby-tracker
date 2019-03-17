
# RugbyTracker - The #1 App For Tracking Team Player Rosters

This app allows you to signup as a coach and easily manage your entire player roster for your rugby team.

## Installation & Usage

To use this app, just clone and run

```ruby
bundle install
```
Then run:

```ruby
rake db:migrate
```

and then run
```ruby
shotgun
```

Enter the host url displayed (eg. http://178.128.13.85:56117) into your web browser to get started!

The first step will be to signup for a new user account using an email and password. After signup go ahead and login to start adding players to your roster. You can add players by name and position and then edit and delete any player on your roster as you choose. On the /viewplayers page you will be able to see your entire roster.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ethanrosenberg/rugby-tracker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RugbyTracker project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'blithe-acrobat-2921'/wine_100/blob/master/CODE_OF_CONDUCT.md).
