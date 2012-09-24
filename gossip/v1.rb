require 'sinatra'
require 'dalli'
require 'pony'

require_relative 'e_card'
require_relative 'sharing'
require_relative 'email'

module Gossip
  def self.cache
    @cache ||= Dalli::Client.new('127.0.0.1:11211', :namespace => 'gossip')
  end
end

class GossipV1 < Sinatra::Base

  get '/share_by_email_or_sms/:id' do |id|
    e_card = Gossip::ECard.find(id)
    params[:e_card] = e_card
    recipients = [
      Gossip::Sharing.get_tokens(params[:emails]),
      Gossip::Sharing.get_tokens(params[:numbers])
    ].flatten.compact
    if params[:name] and params[:name].size > 40
      invalid_name = true
    else
      host = URI.parse(e_card.permalink)
      host = host.host if host.host
      params[:sms_message] = "#{params[:name]} " <<
      "wants you to see this! #{e_card.permalink} " <<
      "Sent from #{host}"
    end
    sent_to_recipients = Gossip::Sharing.send_to_recipients(params)
    sent_to_recipients ||= []

    unless invalid_name
      if recipients.size == sent_to_recipients.size
        {"sent_to" => sent_to_recipients}.to_json
      elsif sent_to_recipients.any?
        {"sent_to" => sent_to_recipients}.to_json
      else
        halt 400, "Couldn't find any valid recipients who hadn't already received this tip."
      end
    else
      halt 400, "Invalid name"
    end
  end

  # ... ~300 more lines ...

end
