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
    correct = []
    correct << "<p>Parent directory:</p>"
    correct << "<ul>"
    correct << "  <li> <a href='../'>../</a>"
    correct << "</ul>"
    correct << "<p>Current directory:</p>"
    correct << "<ul>"
    correct << "  <li> <a href='dir/index.html'>dir_index_md</a>"
    correct << "  <li> <a href='foo.html'>foo_md</a>"
    correct << "  <li> <a href='index.html'>title_index.html</a>"
    correct << "</ul>"
    assert_equal(correct, Madowu::DirectoryMapper.dirmap("test/directorymapper/dir2"))

    #checklink filename
    #     index.md  index.html
    #dir1 no        no
    #dir2 no        yes
    #dir3 yes       no
    #dir4 yes       yes

    #anchor text using header in index.md


  end

  def test_anchor_text
    # markdown without heading
    assert_equal('empty.html',
      Madowu::DirectoryMapper.anchor_text('test/directorymapper/empty.md')
    )

    # markdown without heading
    
    assert_equal('head1',
      Madowu::DirectoryMapper.anchor_text('test/directorymapper/head.md')
    )

    # html
    assert_equal('title_index.html',
      Madowu::DirectoryMapper.anchor_text('test/directorymapper/title.html')
    )

    # dir
    assert_equal('dir1/',
      Madowu::DirectoryMapper.anchor_text('test/directorymapper/dir1')
    )


  end

end

