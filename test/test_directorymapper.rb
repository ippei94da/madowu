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
    correct << "Parent directory:"
    correct << ""
    correct << "* [../](../)"
    correct << ""
    correct << "Current directory:"
    correct << ""
    correct << "* [dir index md](dir/index.html)"
    correct << "* [foo md](foo.html)"
    correct << "* [title index.html](index.html)"
    #correct << "* [dir/](dir/index.html) (dir index md)"
    #correct << "* [foo.html](foo.html) (foo md)"
    #correct << "* [index.html](index.html) (title index.html)"
    assert_equal(correct, Madowu::DirectoryMapper.dirmap("test/directorymapper/dir2"))

    correct = []
    correct << "Parent directory:"
    correct << ""
    correct << "* [../](../)"
    correct << ""
    correct << "Current directory:"
    correct << ""
    correct << "* [生、なま](nama.html)"
    correct << "* [生まれる、うまれる](umareru.html)"
    correct << "* [生やす、はやす](hayasu.html)"
    correct << "* [生命、せいめい](seimei.html)"
    correct << "* [生涯、しょうがい](shougai.html)"
    correct << "* [生糸、きいと](kiito.html)"
    assert_equal(correct, Madowu::DirectoryMapper.dirmap("test/directorymapper/japanese"))

    correct = []
    correct << "Parent directory:"
    correct << ""
    correct << "* [../](../)"
    correct << ""
    correct << "Current directory:"
    correct << ""
    correct << "* [生まれる、うまれる](umareru.html)"
    correct << "* [生糸、きいと](kiito.html)"
    correct << "* [生涯、しょうがい](shougai.html)"
    correct << "* [生命、せいめい](seimei.html)"
    correct << "* [生、なま](nama.html)"
    correct << "* [生やす、はやす](hayasu.html)"
    assert_equal(correct, Madowu::DirectoryMapper.dirmap("test/directorymapper/japanese", true))
  end



  def test_get_title
    # markdown without heading
    #assert_equal('empty.html',
    assert_equal('',
      Madowu::DirectoryMapper.get_title('test/directorymapper/empty.md')
    )

    # markdown without heading

    assert_equal('head',
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

