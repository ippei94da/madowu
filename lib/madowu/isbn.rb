#! /usr/bin/env ruby
# coding: utf-8

require 'pp'
#Amazon::Ecs.debug = true

#
#
#
class Madowu::Isbn

  ROOT_KEY_FILE = ENV['HOME'] + '/.aws/rootkey.csv'
  ASSOCIATEID_FILE = ENV['HOME'] + '/.aws/associateid'

  class AccountFileError < StandardError; end

  #
  def initialize(isbn)
    @isbn = isbn
    [ROOT_KEY_FILE, ASSOCIATEID_FILE].each do |file|
      raise AccountFileError, "Not found #{file}" unless File.exist? file
    end

    hash = {}
    hash[:associate_tag] = File.open(ASSOCIATEID_FILE, 'r').gets.chomp
    File.open(ROOT_KEY_FILE, 'r').readlines.each do |i|
      /(.*)=(.*)/ =~ i
      key, val = $1, $2
      hash[:AWS_access_key_id] = val.chomp if key == 'AWSAccessKeyId'
      hash[:AWS_secret_key]    = val.chomp if key == 'AWSSecretKey'
    end

    Amazon::Ecs.options = hash
    #pp Amazon::Ecs.options
    #exit

    @info = Amazon::Ecs.item_search(
      isbn,
      {:search_index => 'Books', :response_group => 'Medium', :country => 'jp'}
    )
    #pp @info
    #exit
  end

  def title
    @info.items.each { |item| return item.get('ItemAttributes/Title') }
  end

  def author
    @info.items.each { |item| return item.get('ItemAttributes/Author') }
  end

  def isbn
    @info.items.each { |item| return item.get('ItemAttributes/ISBN') }
  end

  def publisher
    @info.items.each { |item| return item.get('ItemAttributes/Publisher') }
  end

  def publication_date
    @info.items.each { |item| return item.get('ItemAttributes/PublicationDate') }
  end

  def url
    @info.items.each { |item| return item.get('DetailPageURL') }
  end
  
  def img_url
    @info.items.each { |item| return item.get('SmallImage/URL') }
  end

end

