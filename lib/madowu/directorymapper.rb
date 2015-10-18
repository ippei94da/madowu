#! /usr/bin/env ruby
# coding: utf-8

#
#
#
class Madowu::DirectoryMapper
  #
  #def initialize()
  #end
  def self.dirmap(dir)
    results = []
    md_dir = Pathname.new(dir)

    results << "<p>Parent directory:</p>"
    results << "<ul>"
    if File.exist?(md_dir.parent + 'index.html')
      results << "  <li> <a href='../index.html'>../</a>"
    else
      results << "  <li> <a href='../'>../</a>"
    end
    results << "</ul>"

    results << "<p>Current directory:</p>"
    results << "<ul>"
    current_entries = []
    cur_dir_entries = Dir.entries(md_dir).sort.delete_if{|i| i =~ /^\./}
    cur_dir_entries.each do |i|
      path = md_dir + i
      if FileTest.directory?(path)
        if FileTest.file?(path + "index.md")
          link_path = (path + "index.html")
          anchor =  self.anchor_text((path + "index.md").to_s)
        elsif FileTest.exist?(path + "index.html")
          link_path = path + "index.html"
          anchor =  self.anchor_text((path + "index.html").to_s)
        else
          link_path = path
          anchor = path
        end
      elsif FileTest.file?(path)
        if path.fnmatch?('*.md')
          link_path = Pathname.new(path.sub_ext('.html'))
          next if FileTest.exist? link_path
          #anchor =  self.anchor_text((path + "index.md").to_s)
          anchor =  self.anchor_text((path.to_s))
        elsif path.fnmatch?('*.html')
          link_path = Pathname.new(path.sub_ext('.html'))
          #next if FileTest.exist? link_path
          pp path.to_s
          anchor =  self.anchor_text(path.to_s)
        end
      else
        #next
        #results << "  <li> <a href='#{i}'>#{i}</a>"}
      end
      link_path = link_path.to_s.sub(/^#{md_dir}\//, '')
      results << "  <li> <a href='#{link_path}'>#{anchor}</a>"
    end
    results << "</ul>"
    results
  end

  def self.anchor_text(path)
    if FileTest.directory?(path)
      result = Pathname.new(path).basename.to_s + "/"
    else
      if /\.md$/ =~ path
        result = Madowu::HtmlGenerator.get_title(path)
        if result.empty?
          result = Pathname.new(path).
            sub_ext('.html').
            basename
        end
      elsif /\.html$/ =~ path
        line = `grep \\<title\\> #{path}`
        /\<title\>(.*)\<\/title\>/ =~ line
        result = $1
        result = Pathname.new(path).basename if result.empty?
      end
    end
    result.to_s
  end
end

