#!/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'twitter'
require 'pp'
require 'yaml'

token = YAML.load_file(File.expand_path('../../', __FILE__)+'/yaml/token.yaml')

Twitter.configure do |cnf|
  cnf.consumer_key    = token['consumer_key']
  cnf.consumer_secret = token['consumer_secret']
end

# OAuth アクセストークンの読み込み
@client = Twitter::Client.new(
  :oauth_token => token['oauth_token'],
  :oauth_token_secret => token['oauth_token_secret']
)

class TWBot
	@@tweet = YAML.load_file(File.expand_path('../', __FILE__)+'/tweet.yaml')
	def get_rand_element(array)
		num = rand(array.length)+1
		choices = []
		(1..num).each do
			elm = array[ rand(array.length) ]
			if !choices.include?(elm)
				choices.push(elm)
			end
		end
		choices[rand(choices.length)]
	end

	def update(hash={:tw_target_name=>'ファルネーゼ'})
		text = get_rand_element(@@tweet)['text']
		if text.class == String
			p text
		elsif text.class == Array
			str = ''
			hash = 
			text.each do |elm|
				if elm.class == String
					str += elm.to_s
				elsif elm.class == Symbol
					str += hash[elm]
				end
			end
			p str
		end
	end
end

