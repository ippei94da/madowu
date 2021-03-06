#! /usr/bin/env ruby
# coding: utf-8

#
#
#
class Madowu::HtmlGenerator
  DEFAULT_MARKDOWN_COMMAND = 'markdown'

  #
  def initialize(md_file, markdown = DEFAULT_MARKDOWN_COMMAND)
    @md_file = md_file
    @markdown = markdown || DEFAULT_MARKDOWN_COMMAND
    @markup_lines = `#{@markdown} #{@md_file}`.split("\n")
  end

  #unless ARGV.size == 1
  #  PRINTUSAGE;
  #  exit
  #end

  def self.get_title(md_file)
    #`grep -E '^#' #{md_file} | head -n 1`.sub(/^#\s*/, '').strip
    result = ''
    str = `head -n 1 #{md_file}`
    pattern = /^%\s*/
    result = str.sub(/^%\s*/, '').chomp if pattern =~ str
    result
  end

  # 'title' element in head is set as first /^#/ in md_file.
  def generate(options = {})
    embed_outline(options[:selflink]) if options[:outline]

    #if options[:dirmap]
    #  md_dir = Pathname.new(@md_file).dirname.expand_path
    #  embed_sidebar( Madowu::DirectoryMapper.dirmap(md_dir) )
    #end

    if options[:sidebar]
      #lines = File.open( options[:sidebar], "r").readlines
      lines = `#{@markdown} #{options[:sidebar]}`.split("\n")
      embed_sidebar(lines)
    end

    result = [
      make_header(options[:css], options[:charset]),
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

  def embed_outline(option_selflink = false)
    new_lines = []
    outlines = []
    anchor_index = 0
    @markup_lines.each do |line|
      #pp line
      new_line = line
      if /^\<h(\d)(.*?)\>(.*)\<\/h(\d)\>$/ =~ line
        new_line = ''
        new_line += "<h#{$1}"
        new_line += "#{$2}" unless $2.empty?
        new_line += "><a name='#{anchor_index.to_s}'"
        new_line += " href='\##{anchor_index.to_s}'" if option_selflink
        new_line += ">#{$3}</a></h#{$1}>"

        outlines << "#{' ' * (($1.to_i) -1) * 4}* [#{$3}](\##{anchor_index})"
        anchor_index += 1
      end
      #if /^\<h(\d)\>(.*)\<\/h(\d)\>$/ =~ line
      #  new_line = ''
      #  new_line += "<h#{$1}><a name='#{anchor_index.to_s}'"
      #  new_line += " href='\##{anchor_index.to_s}'" if option_selflink
      #  new_line += ">#{$2}</a></h#{$3}>"

      #  outlines << "#{' ' * (($1.to_i) -1) * 4}* [#{$2}](\##{anchor_index})"
      #  anchor_index += 1
      #end
      new_lines << new_line
    end

    io = IO.popen(@markdown, "r+")
    io.write outlines.join("\n")
    io.close_write
    outlines = io.readlines.map {|i| i.chomp}

    outlines.unshift( "<div class='header'>", "<p>Outline:</p>")
    outlines.push "</div>"

    @markup_lines = outlines + new_lines

    #new_lines = []
    #outlines = []
    #outlines << "<div class='header'>"
    #outlines << "<p>Outline:</p>"
    #outlines << "<ul class='outline'>"
    #counter = 0

    #@markup_lines.each do |line|
    #  #pp line
    #  new_line = line
    #  if /^\<h(\d)\>(.*)\<\/h(\d)\>$/ =~ line
    #    new_line = ''
    #    new_line += "<h#{$1}><a name='#{counter.to_s}'"
    #    new_line += " href='\##{counter.to_s}'" if option_selflink
    #    new_line += ">#{$2}</a></h#{$3}>"
    #    outlines << "  <li><a href='\##{counter}'>#{' + ' * ($1.to_i-1)}#{$2}</a></ll>"
    #    counter += 1
    #  end
    #  new_lines << new_line
    #end
    #outlines << "</ul>"
    #outlines << "</div>"

    #@markup_lines = outlines + new_lines
  end

  def make_header(css, charset)
    #title = `grep -E '^#' #{@md_file} | head -n 1`.sub(/^#\s*/, '').strip
    title = self.class.get_title(@md_file)

    charset ||= 'us-ascii'

    results = []
    results << "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN'>"
    results << "<html lang=\'ja\'>"
    results << "<head>"
    results << "  <title>#{title}</title>"
    results << "  <meta http-equiv='Content-Type' content='text/html; charset=#{charset}'>"

    if css
      if File.exist? css
        md_dir = Pathname.new(@md_file).dirname.expand_path
        css_path = Pathname.new(css).expand_path
        rel_path = css_path.relative_path_from(md_dir)
        #pp md_dir
        #pp css_path
        #pp rel_path
        results << "  <link rel='stylesheet' type='text/css' href='#{rel_path}' media='all'>"
      end
    end
    results << "</head>"
    results << "<body>"
    results << "<div class='main'>"
    results << "<div class='body'>"
  end

end

