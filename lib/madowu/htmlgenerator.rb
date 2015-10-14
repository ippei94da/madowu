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
    @markup_lines = `#{MARKDOWN_COMMAND} #{@md_file}`.split("\n")
  end

  #unless ARGV.size == 1
  #  PRINTUSAGE;
  #  exit
  #end


  # 'title' element in head is set as first /^#/ in md_file.
  def generate(options = {})
    embed_outline if options[:outline]

    embed_sidebar(dir_map) if options[:map]

    result = [
      make_header,
      @markup_lines,
      "</div></div></body></html>",
      ''
    ].join("\n")
  end

  private

  def embed_sidebar(lines)
    lines.unshift "<div class='sidebar'>"
    lines.push "</div>"
    @markup_lines += lines
  end

  def dir_map
    #pp @md_file
    parent_entries = []
    current_entries = []
    subdirs_entries = []
    md_dir = Pathname.new( @md_file).dirname
    cur_dir_entries = Dir.entries(md_dir).sort.delete_if{|i| i =~ /^\./}
    cur_dir_entries.each do |i|
      #pp i
      path = md_dir + i
      #pp path
      if FileTest.directory?(path)
        if FileTest.exist?(path + "index.html") || FileTest.file?(path + "index.md")
          subdirs_entries << (path + 'index.html')
        else
          subdirs_entries << (path)
        end
      elsif FileTest.file?(path)
        new_path = Pathname.new(path.to_s.sub( /\.md$/, ".html"))
        current_entries << new_path
      else
          # do nothing
      end
    end
    current_entries.uniq!

    if File.exist?(md_dir.parent + 'index.html')
      parent_entries << md_dir.parent + 'index.html'
    else
      parent_entries << md_dir.parent
    end

    results = []
    results << "<p>Parent directory:</p>"
    results << "<ul>"
    parent_entries.each {|i| "  <li> <a href='#{i}'>#{i}</a>"}
    results << "</ul>"
    results << "<p>Current directory:</p>"
    results << "<ul>"
    current_entries.each {|i| "  <li> <a href='#{i}'>#{i}</a>"}
    results << "</ul>"
    results << "<p>Subdirectory:</p>"
    results << "<ul>"
    subdirs_entries.each {|i| "  <li> <a href='#{i}'>#{i}</a>"}
    results << "</ul>"
    results
  end

  def embed_outline
    new_lines = []
    outlines = []
    outlines << "<div class='header'>"
    outlines << "<p>Outline:</p>"
    outlines << "<ul class='outline'>"
    counter = 0

    @markup_lines.each do |line|
      #pp line
      new_line = line
      if /^\<h(\d)\>(.*)\<\/h(\d)\>$/ =~ line
        new_line = "<h#{$1}><a name='#{counter.to_s}'>#{$2}</a></h#{$3}>"
        outlines << "  <li><a href='\##{counter}'>#{'+' * ($1.to_i-1)}#{$2}</a></ll>"
        counter += 1
      end
      new_lines << new_line
    end
    outlines << "</ul>"
    outlines << "</div>"

    #pp outlines
    #pp new_lines

    @markup_lines = outlines + new_lines
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

