# Simple Messenger App

This is a very simple example of how to create a text messenger app for use with [twilio](http://twilio.com) and [heroku](http://heroku.com).

To get this app working, you will need to:
* sign up for twilio and get a sms capable number
* signup for heroku and install the CLI toolbelt
* create a new heroku app (example: $ heroku create)
* deploy ($ heroku push origin master)
* migrate your database ($ heroku run rake db:schema:load)
* set the following instances in your production (and developement) environment (example: $ heroku config:set MESSENGER_TWILIO_SID=12345): 
  * MESSENGER_TWILIO_SID (your twilio sid)
  * MESSENGER_TWILIO_SECRET_TOKEN (your twilio secret token)
  * MESSENGER_TWILIO_NUMBER (the twilio number you are using)

That's it. Have fun.