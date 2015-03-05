class TwilioController < ApplicationController

	# override rails security for external api request
	skip_before_filter :verify_authenticity_token

	def sms
		incoming_user = User.find_by(number: params[:From])
		message_body = params[:Body]

		# look for subscribe request
		if message_body.downcase.strip == "subscribe"
			new_user = User.new(number: params[:From])
			#check for double subscribe
			if new_user.save
				response = Twilio::TwiML::Response.new do |r|
				  r.Sms 'Welcome to messenger. You have been subscribed'
				end
			else
				response = Twilio::TwiML::Response.new do |r|
				  r.Sms 'You are already subscribed.'
				end
			end
			render xml: response.text	
		# if valid user, send the message to everyone
		elsif incoming_user 
			account_sid = ENV['MESSENGER_TWILIO_SID']
			auth_token = ENV['MESSENGER_TWILIO_SECRET_TOKEN']
			from_number = ENV['MESSENGER_TWILIO_NUMBER']
			@client = Twilio::REST::Client.new account_sid, auth_token
			
			User.all.each do |user| 
				message = @client.account.messages.create(
					:body => message_body,
				    :to => user.number,
				    :from => from_number)
				puts message.to
			end
			render status: :ok
		# otherwise prompt the user to subscribe
		else
			response = Twilio::TwiML::Response.new do |r|
			  r.Sms "Please 'subscribe' to send messages."
			end
			render xml: response.text	
		end
	end
end