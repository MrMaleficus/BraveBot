require 'discordrb'
require 'redis'
require 'dotenv/load'

Dotenv.load

bot = Discordrb::Bot.new token: ENV['BOT_TOKEN']

bot.ready do |event|
  puts "Connecté en tant que #{bot.profile.username} (ID: #{bot.profile.id})"
  puts "Connecté avec succès"
end

bot.run 