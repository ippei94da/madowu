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

    results << "Parent directory:"
    results << ""
    if File.exist?(md_dir.parent + 'index.html')
      results << "* [../](../index.html)"
    else
      results << "* [../](../)"
    end
    results << ""

    results << "Current directory:"
    results << ""
    current_entries = []
    cur_dir_entries = Dir.entries(md_dir).sort.delete_if{|i| i =~ /^\./}
    cur_dir_entries.each do |i|
      path = md_dir + i
      anchor = i
      if FileTest.directory?(path)
        if FileTest.file?(path + "index.md")
          link_path = (path + "index.html")
          title = self.get_title((path + "index.md").to_s)
        elsif FileTest.exist?(path + "index.html")
          link_path = path + "index.html"
          title = self.get_title((path + "index.html").to_s)
        else
          link_path = path
          title = nil
        end
        anchor += "/"
      else
        if path.fnmatch?('*.md')
          link_path = Pathname.new(path.sub_ext('.html'))
          anchor = link_path
          title = self.get_title((path.to_s))
        elsif path.fnmatch?('*.html')
          next if FileTest.exist? (path.sub_ext('.md'))
          link_path = Pathname.new(path.sub_ext('.html'))
          title = self.get_title(path.to_s)
        else
          link_path = path
          title = nil
        end
      end
      link_path = link_path.to_s.sub(/^#{md_dir}\//, '')
      anchor = anchor.to_s.sub(/^#{md_dir}\//, '')
      line = "* [#{anchor}](#{link_path})"
      line += " (#{title})" unless title.to_s.empty?
      results << line
    end
    #results << "</ul>"
    results
  end

  def self.get_title(path)
    if FileTest.directory?(path)
      result = Pathname.new(path).basename.to_s + "/"
    else
      if /\.md$/ =~ path
        result = Madowu::HtmlGenerator.get_title(path)
        if result.empty?
          result = ''
        end
      elsif /\.html$/ =~ path
        line = `grep \\<title\\> #{path}`
        /\<title\>(.*)\<\/title\>/ =~ line
        result = $1 || ''
        result = Pathname.new(path).basename if result.empty?
      end
    end
    result.to_s
  end
end

