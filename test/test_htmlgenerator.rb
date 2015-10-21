#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class Madowu::HtmlGenerator
  public :embed_outline, :embed_sidebar
  attr_reader :markup_lines
end

class TC_HtmlGenerator < Test::Unit::TestCase
  def setup
    @h00 = Madowu::HtmlGenerator.new("test/empty.md")
    @h01 = Madowu::HtmlGenerator.new("test/head.md")
    @h02 = Madowu::HtmlGenerator.new("test/head1.md")
  end

  def test_generate
    correct = []
    correct << "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'>"
    correct << "<HTML lang=\'ja\'>"
    correct << "<head>"
    correct << "  <title></title>"
    correct << "  <meta http-equiv='Content-Type' content='text/html; charset=us-ascii'>"
    correct << "</head>"
    correct << "<body>"
    correct << "<div class='main'>"
    correct << "<div class='body'>"
    correct << ""
    correct << "</div></div></body></html>"
    correct << ""
    correct = correct.join("\n")
    assert_equal( correct, @h00.generate)

    # charset
    correct = []
    correct << "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'>"
    correct << "<HTML lang=\'ja\'>"
    correct << "<head>"
    correct << "  <title></title>"
    correct << "  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>"
    correct << "</head>"
    correct << "<body>"
    correct << "<div class='main'>"
    correct << "<div class='body'>"
    correct << ""
    correct << "</div></div></body></html>"
    correct << ""
    correct = correct.join("\n")
    assert_equal( correct, @h00.generate({:charset => "UTF-8"}))

    h04 = Madowu::HtmlGenerator.new("test/subdir/empty.md")
    options = {:css => "test/test.css"}
    correct = []
    correct << "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'>"
    correct << "<HTML lang=\'ja\'>"
    correct << "<head>"
    correct << "  <title></title>"
    correct << "  <meta http-equiv='Content-Type' content='text/html; charset=us-ascii'>"
    correct << "  <link rel='stylesheet' type='text/css' href='../test.css' media='all'>"
    correct << "</head>"
    correct << "<body>"
    correct << "<div class='main'>"
    correct << "<div class='body'>"
    correct << ""
    correct << "</div></div></body></html>"
    correct << ""
    correct = correct.join("\n")
    assert_equal( correct, h04.generate(options))
  end

  def test_embed_outline
    correct = []
    correct << "<div class='header'>"
    correct << "<p>Outline:</p>"
    correct << "<ul class='outline'>"
    correct << "  <li><a href='#0'>head1</a></ll>"
    correct << "  <li><a href='#1'> + head2</a></ll>"
    correct << "  <li><a href='#2'> +  + head3</a></ll>"
    correct << "  <li><a href='#3'> +  +  + head4</a></ll>"
    correct << "  <li><a href='#4'> +  +  +  + head5</a></ll>"
    correct << "  <li><a href='#5'> +  +  +  +  + head6</a></ll>"
    correct << "</ul>"
    correct << "</div>"
    correct << "<h1><a name='0'>head1</a></h1>"
    correct << ""
    correct << "<p>line1</p>"
    correct << ""
    correct << "<h2><a name='1'>head2</a></h2>"
    correct << ""
    correct << "<p>line2</p>"
    correct << ""
    correct << "<h3><a name='2'>head3</a></h3>"
    correct << ""
    correct << "<p>line3</p>"
    correct << ""
    correct << "<h4><a name='3'>head4</a></h4>"
    correct << ""
    correct << "<p>line4</p>"
    correct << ""
    correct << "<h5><a name='4'>head5</a></h5>"
    correct << ""
    correct << "<p>line5</p>"
    correct << ""
    correct << "<h6><a name='5'>head6</a></h6>"
    correct << ""
    correct << "<p>line6</p>"
    @h01.embed_outline
    assert_equal( correct, @h01.markup_lines)

    correct = []
    correct << "<div class='header'>"
    correct << "<p>Outline:</p>"
    correct << "<ul class='outline'>"
    correct << "  <li><a href='#0'>head1</a></ll>"
    correct << "</ul>"
    correct << "</div>"
    correct << "<h1><a name='0' href='#0'>head1</a></h1>"
    @h02.embed_outline(true)
    assert_equal( correct, @h02.markup_lines)
  end

  def test_embed_sidebar
    lines = ['1', '2' ]
    @h02.embed_sidebar(lines)
    correct = []
    correct << "<h1>head1</h1>"
    correct << "<div class='sidebar'>"
    correct << "1"
    correct << "2"
    correct << "</div>"
    assert_equal(correct, @h02.markup_lines)
  end

end

