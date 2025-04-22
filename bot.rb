require 'discordrb'
require 'redis'
require 'dotenv/load'

Dotenv.load

redis_sub = Redis.new(host: 'redis')

bot = Discordrb::Bot.new token: ENV['BOT_TOKEN']

Thread.new do
  redis_sub.subscribe('discord_messages') do |on|
    on.message do |channel, message|
      begin
        channel_id, *message_parts = message.split(' ', 2)
        content = message_parts.join(' ')
        
        discord_channel = bot.channel(channel_id.to_i)
        if discord_channel
          discord_channel.send(content)
        else
          puts "Channel #{channel_id} introuvable"
        end
      rescue => e
        puts "Une erreur s'est produite: #{e.message}"
      end
    end
  end
end

bot.ready do |event|
  puts "Connecté en tant que #{bot.profile.username} (ID: #{bot.profile.id})"
  puts "Connecté avec succès"
end

bot.run 