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
    correct << "<html lang=\'ja\'>"
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
    correct << "<html lang=\'ja\'>"
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
    correct << "<html lang=\'ja\'>"
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
    correct = [
      "<div class='header'>",
      "<p>Outline:</p>",
      "<ul>",
      "<li><a href=\"#0\">head1</a>",
      "<ul>",
      "<li><a href=\"#1\">head2</a>",
      "<ul>",
      "<li><a href=\"#2\">head3</a>",
      "<ul>",
      "<li><a href=\"#3\">head4</a>",
      "<ul>",
      "<li><a href=\"#4\">head5</a>",
      "<ul>",
      "<li><a href=\"#5\">head6</a></li>",
      "</ul></li>",
      "</ul></li>",
      "</ul></li>",
      "</ul></li>",
      "</ul></li>",
      "</ul>",
      "</div>",
      "<h1><a name='0'>head1</a></h1>",
      "",
      "<p>line1</p>",
      "",
      "<h2><a name='1'>head2</a></h2>",
      "",
      "<p>line2</p>",
      "",
      "<h3><a name='2'>head3</a></h3>",
      "",
      "<p>line3</p>",
      "",
      "<h4><a name='3'>head4</a></h4>",
      "",
      "<p>line4</p>",
      "",
      "<h5><a name='4'>head5</a></h5>",
      "",
      "<p>line5</p>",
      "",
      "<h6><a name='5'>head6</a></h6>",
      "",
      "<p>line6</p>"
    ]
    @h01.embed_outline
    assert_equal( correct, @h01.markup_lines)

    correct = []
    correct << "<div class='header'>"
    correct << "<p>Outline:</p>"
    correct << "<ul>"
    correct << '<li><a href="#0">head1</a></li>'
    correct << "</ul>"
    correct << "</div>"
    correct << "<h1><a name='0' href='#0'>head1</a></h1>"
    @h02.embed_outline(true)
    assert_equal( correct, @h02.markup_lines)

    h03 = Madowu::HtmlGenerator.new("test/head_pandoc.md")
    correct = []
    correct << "<div class='header'>"
    correct << "<p>Outline:</p>"
    correct << "<ul>"
    correct << '<li><a href="#0">pandoc</a></li>'
    correct << "</ul>"
    correct << "</div>"
    correct << "<h1 id=\"section\"><a name='0' href='#0'>pandoc</a></h1>"
    h03.embed_outline(true)
    assert_equal( correct, h03.markup_lines)

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

  def test_get_title
    assert_equal('title foo'  , Madowu::HtmlGenerator.get_title("test/directorymapper/dir1/foo.md"))
    assert_equal('dir index md', Madowu::HtmlGenerator.get_title("test/directorymapper/dir2/dir/index.md"))
    assert_equal('foo md'  , Madowu::HtmlGenerator.get_title("test/directorymapper/dir2/foo.md"))
    assert_equal(''           , Madowu::HtmlGenerator.get_title("test/directorymapper/empty.md"))
    assert_equal('title file1', Madowu::HtmlGenerator.get_title("test/directorymapper/file1.md"))
    assert_equal('head' , Madowu::HtmlGenerator.get_title("test/directorymapper/head.md"))
    assert_equal(''           , Madowu::HtmlGenerator.get_title("test/empty.md"))
    assert_equal(''           , Madowu::HtmlGenerator.get_title("test/head.md"))
    assert_equal(''           , Madowu::HtmlGenerator.get_title("test/head1.md"))
    assert_equal(''           , Madowu::HtmlGenerator.get_title("test/head_pandoc.md"))
    assert_equal(''           , Madowu::HtmlGenerator.get_title("test/subdir/empty.md"))

  end

end

