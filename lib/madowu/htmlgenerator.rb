#! /usr/bin/env ruby
# coding: utf-8

#
#
#
class Madowu::HtmlGenerator
  MARKDOWN_COMMAND = 'markdown'

  #
  def initialize(md_file)
    @md_file = md_file
    @markup_str = `#{MARKDOWN_COMMAND} #{@md_file}`
  end

  #unless ARGV.size == 1
  #  PRINTUSAGE;
  #  exit
  #end


  # 'title' element in head is set as first /^#/ in md_file.
  def generate(options = {})
    embed_outline if options[:outline]

    result = [
      make_header,
      @markup_str,
      "</div></div></body></html>",
      ""
    ].join("\n")
  end

  private

  def embed_outline
    new_lines = []
    outlines = []
    outlines << "<div class='header'>"
    outlines << "<ul class='outline'>"
    counter = 0

    @markup_str.split("\n").each do |line|
      #pp line
      new_line = line
      if /^\<h(\d)\>(.*)\<\/h(\d)\>$/ =~ line
        new_line = "<h#{$1}><a name='#{counter.to_s}'>#{$2}</a><h#{$3}>"
        outlines << "  <li><a href='\##{counter}'>#{'+' * ($1.to_i-1)}#{$2}</a></ll>"
        counter += 1
      end
      new_lines << new_line
    end
    outlines << "</ul>"
    outlines << "</div>"

    #pp outlines
    #pp new_lines

    @markup_str = (outlines + new_lines + ['']).join("\n")
    #puts @markup_str
    #exit

  end

  def make_header
    title = `grep -E '^#' #{@md_file} | head -n 1`.sub(/^#\s*/, '').strip

    str = <<HERE
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML lang=\"ja\">
<head>
  <title>#{title}</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="theme.css" media="all">
</head>
<body>
<div class="main">
<div class="body">
HERE
  end

end

