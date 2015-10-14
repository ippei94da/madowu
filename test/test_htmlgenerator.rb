#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class Madowu::HtmlGenerator
  public :embed_outline
  attr_reader :markup_str
end

class TC_HtmlGenerator < Test::Unit::TestCase
  def setup
    @h00 = Madowu::HtmlGenerator.new("test/empty.md")
    @h01 = Madowu::HtmlGenerator.new("test/head.md")
  end

  def test_generate
    correct = <<HERE
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML lang=\"ja\">
<head>
  <title></title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="theme.css" media="all">
</head>
<body>
<div class="main">
<div class="body">



</div></div></body></html>
HERE
    assert_equal( correct, @h00.generate)
  end

  def test_embed_outline
    correct = <<HERE
<div class='header'>
<ul class='outline'>
  <li><a href='#0'>head1</a></ll>
  <li><a href='#1'>+head2</a></ll>
  <li><a href='#2'>++head3</a></ll>
  <li><a href='#3'>+++head4</a></ll>
  <li><a href='#4'>++++head5</a></ll>
  <li><a href='#5'>+++++head6</a></ll>
</ul>
</div>
<h1><a name='#0'>head1</a><h1>

<p>line1</p>

<h2><a name='#1'>head2</a><h2>

<p>line2</p>

<h3><a name='#2'>head3</a><h3>

<p>line3</p>

<h4><a name='#3'>head4</a><h4>

<p>line4</p>

<h5><a name='#4'>head5</a><h5>

<p>line5</p>

<h6><a name='#5'>head6</a><h6>

<p>line6</p>
HERE
    
    @h01.embed_outline
    #puts correct
    #puts "-"*60
    #puts @h01.markup_str
    #exit
    assert_equal( correct, @h01.markup_str)
  end

end

