#!/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'twitter'
require 'pp'
require 'yaml'


class TWBot
	TOKEN = YAML.load_file(File.expand_path('../../', __FILE__)+'/yaml/token.yaml')
	Twitter.configure do |cnf|
	  cnf.consumer_key    = TOKEN['consumer_key']
	  cnf.consumer_secret = TOKEN['consumer_secret']
	end
	# OAuth アクセストークンの読み込み
	@@client = Twitter::Client.new(
	  :oauth_token => TOKEN['oauth_token'],
	  :oauth_token_secret => TOKEN['oauth_token_secret']
	)
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
		str = ''
		if text.class == String
			str = text
		elsif text.class == Array
			hash = 
			text.each do |elm|
				if elm.class == String
					str += elm.to_s
				elsif elm.class == Symbol
					str += hash[elm]
				end
			end
		end
		_tw_update(str)
	end

	def _tw_update(str)
		@@client.update(str)
	end
end

