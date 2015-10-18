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
      anchor = i
      if FileTest.directory?(path)
        if FileTest.file?(path + "index.md")
          link_path = (path + "index.html")
          title = self.anchor_text((path + "index.md").to_s)
        elsif FileTest.exist?(path + "index.html")
          link_path = path + "index.html"
          title = self.anchor_text((path + "index.html").to_s)
        else
          link_path = path
          title = nil
        end
        anchor += "/"
      else
        if path.fnmatch?('*.md')
          link_path = Pathname.new(path.sub_ext('.html'))
          anchor = link_path
          next if FileTest.exist? link_path
          title = self.anchor_text((path.to_s))
        elsif path.fnmatch?('*.html')
          link_path = Pathname.new(path.sub_ext('.html'))
          title = self.anchor_text(path.to_s)
        else
          link_path = path
          title = nil
        end
      end
      link_path = link_path.to_s.sub(/^#{md_dir}\//, '')
      anchor = anchor.to_s.sub(/^#{md_dir}\//, '')
      line = "  <li> <a href='#{link_path}'>#{anchor}</a>"
      line += "(#{title})" if title
      results << line
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

