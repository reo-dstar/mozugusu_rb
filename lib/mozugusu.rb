#!/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'twitter'
require 'pp'
require 'yaml'

token = YAML.load_file(File.expand_path('../../', __FILE__)+'/yaml/token.yaml')
pp token
Twitter.configure do |cnf|
  cnf.consumer_key    = token['consumer_key']
  cnf.consumer_secret = token['consumer_secret']
end

# OAuth アクセストークンの読み込み
@client = Twitter::Client.new(
  :oauth_token => token['oauth_token'],
  :oauth_token_secret => token['oauth_token_secret']
)


@client.update('test2')
