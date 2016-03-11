#! /usr/bin/env ruby
# coding: utf-8

## This test depends on Amazon Web Service...

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"


class Madowu::Isbn
  attr_accessor :info
end

#I00 = Madowu::Isbn.new('479803925X')

class TC_Isbn < Test::Unit::TestCase
  #def setup
  #  #@i00 = Madowu::Isbn.new('', 'test/isbn/479803925X.xml')
  #end

  #def test_title
  #  assert_equal('プログラムはこうして作られるプログラマの頭の中をのぞいてみよう',
  #               I00.title)
  #end

  #def test_author
  #  assert_equal('平山 尚(株式会社セガ)', I00.author)
  #end

  #def test_isbn
  #  assert_equal('479803925X', I00.isbn)
  #end

  #def test_publisher
  #  assert_equal('秀和システム', I00.publisher)
  #end

  #def test_publicationDate
  #  assert_equal('2013-09-25', I00.publication_date)
  #end
  #
  #

#  def test_url
#    assert_equal("http://www.amazon.co.jp/%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0%E3%81%AF%E3%81%93%E3%81%86%E3%81%97%E3%81%A6%E4%BD%9C%E3%82%89%E3%82%8C%E3%82%8B%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9E%E3%81%AE%E9%A0%AD%E3%81%AE%E4%B8%AD%E3%82%92%E3%81%AE%E3%81%9E%E3%81%84%E3%81%A6%E3%81%BF%E3%82%88%E3%81%86-%E5%B9%B3%E5%B1%B1-%E5%B0%9A-%E6%A0%AA%E5%BC%8F%E4%BC%9A%E7%A4%BE%E3%82%BB%E3%82%AC/dp/479803925X%3FSubscriptionId%3DAKIAIRDYXYLFLVKUASUQ%26tag%3Dippei94da-22%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D479803925X", I00.url)
#  end
#
#  def test_img_url
#    assert_equal("http://ecx.images-amazon.com/images/I/41td-P03xmL._SL75_.jpg",
#                 I00.img_url)
#    
#  end
end

