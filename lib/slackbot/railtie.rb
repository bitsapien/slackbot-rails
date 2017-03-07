require 'rails'
 
class Slackbot::Railtie < Rails::Railtie
	def self.enable_notifications
		config.try(:slackbot_rails_enable)
	end
end