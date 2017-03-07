require 'slackbot/rails/engine'
require 'slackbot/rails/version'
require 'slack-notifier'
require 'json'

module Slackbot
  module Rails
    extend ActiveSupport::Concern

    module ClassMethods
      def bot
        @bot ||= Slack::Notifier.new slackbot_rails_options[:bot][:webhook] do 
          defaults channel: '#general',
                   username: 'Untitled'
        end
      end


      def push_to_bot(message)
        begin
          bot.ping(message, channel: slackbot_rails_options[:bot][:channel], username: slackbot_rails_options[:bot][:name])
        rescue Exception => e
          logger.fatal "[Slackbot::Rails] Something went wrong with pushing to the bot:"
          logger.fatal "[Slackbot::Rails] #{e}"
        end
      end

      def notify_bot(options = {})
        begin
        cattr_accessor :slackbot_rails_options
        self.slackbot_rails_options = options
        if slackbot_rails_options[:message][:create].present?
          after_create :push_create_notification_to_bot
        end
        if slackbot_rails_options[:message][:update].present?
          after_update :push_update_notification_to_bot
        end
        rescue Exception => e
          logger.fatal "[Slackbot::Rails] Something went wrong with pushing to the bot:"
          logger.fatal "[Slackbot::Rails] #{e}"
        end          
      end
    end

    private

    def push_create_notification_to_bot
      action = "create"
      self.class.push_to_bot build_message(action)
    end

    def push_update_notification_to_bot
      action = "update"
      self.class.push_to_bot build_message(action)
    end

    def build_message(action)
      begin
      message = slackbot_rails_options[:message][action.to_sym]

      evaluate = message.scan(/{(.*?)}/).flatten
      values = evaluate.inject({}) {|h,e| h.merge!(e => e.to_s.split('.').inject(self) {|o, a| o.try(a)})}
      ready = message
      values.each do |k,v|
        ready = ready.gsub!("{#{k}}", v.to_s)
      end
      
      rescue Exception => e
      logger.fatal e.message
      end
      ready
    end
  end
end

ActiveRecord::Base.send :include, Slackbot::Rails
