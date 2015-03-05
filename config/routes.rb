Rails.application.routes.draw do
  root 'home#index'
  get 'test', to: 'twilio#test'
  get 'sms', to: 'twilio#sms'
end
