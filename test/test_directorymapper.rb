#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "pkg/klass.rb"

class TC_Klass < Test::Unit::TestCase
  #def setup
  #  @k = Klass.new
  #end

  def test_map
    #correct = []
    #correct << "<p>Parent directory:</p>"
    #correct << "<ul>"
    #correct << "  <li> <a href='../'>../</a>"
    #correct << "</ul>"
    #correct << "<p>Current directory:</p>"
    #correct << "<ul>"
    #correct << "  <li> <a href='dir/index.html'>dir/</a> (dir_index_md)"
    #correct << "  <li> <a href='foo.html'>foo.html</a> (foo_md)"
    #correct << "  <li> <a href='index.html'>index.html</a> (title_index.html)"
    #correct << "</ul>"
    #assert_equal(correct, Madowu::DirectoryMapper.dirmap("test/directorymapper/dir2"))

    ##pp Madowu::DirectoryMapper.dirmap("/home/ippei/doc/bookmark/")

    correct = []
    correct << "Parent directory:"
    correct << ""
    correct << "* [../](../)"
    correct << ""
    correct << "Current directory:"
    correct << ""
    correct << "* [dir/](dir/index.html) (dir_index_md)"
    correct << "* [foo.html](foo.html) (foo_md)"
    correct << "* [index.html](index.html) (title_index.html)"
    assert_equal(correct, Madowu::DirectoryMapper.dirmap("test/directorymapper/dir2"))
  end

  def test_get_title
    # markdown without heading
    #assert_equal('empty.html',
    assert_equal('',
      Madowu::DirectoryMapper.get_title('test/directorymapper/empty.md')
    )

    # markdown without heading
    
    assert_equal('head1',
      Madowu::DirectoryMapper.get_title('test/directorymapper/head.md')
    )

    # html
    assert_equal('title_index.html',
      Madowu::DirectoryMapper.get_title('test/directorymapper/title.html')
    )

    # dir
    assert_equal('dir1/',
      Madowu::DirectoryMapper.get_title('test/directorymapper/dir1')
    )


  end

end

