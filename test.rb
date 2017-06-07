require 'yaml/store'
store = YAML.load_file 'tweet.yml'
store['tweet_stored'].each do |key,value|
    puts "#{key} is #{value}"
end
