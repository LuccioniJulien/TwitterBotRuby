#!/usr/bin/env ruby
require 'Twitter'
require 'yaml/store'
def oathTwitter
  client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ""
      config.consumer_secret     = ""
      config.access_token        = ""
      config.access_token_secret = ""
  end
end
def tweetTarget(client)
  client.search("meme spongebob is dumb").take(10).each do |tweet|
    array_before = tweet.text.downcase.split(//)
    array_after=Array.new
    bool=true
      i=0
      array_before.each do |a|
        if i%2==0
          array_after << a.upcase
        else
          array_after << a
        end
        i+=1
      end
      text=array_after.join("")
      store = YAML.load_file 'tweet.yml'
      store['tweet_stored'].each do |key,value|
        if key==tweet.id
          bool=false
          break
        end
      end
      if bool
        puts "#{tweet.user.screen_name}: #{tweet.text}"
        client.update_with_media("@#{tweet.user.screen_name} #{text}"[0..139],File.new("image/spongebob.jpg"),in_reply_to_status_id: tweet.id)
        store['tweet_stored'][+tweet.id]=tweet.text
        File.open('tweet.yml','w') do |h|
          h.write store.to_yaml
        end
        puts "tweet ok"
      else
        puts "pas de tweet"
      end
    puts "fin"
  end
end

tweetTarget(oathTwitter)
