require File.expand_path(File.dirname(__FILE__) + '/helper')

describe "vimdb keys" do
  it "lists all keys by default" do
    vimdb 'keys'
    stdout.must_match /928 rows/
  end

  it 'searches :key field by default' do
    vimdb 'keys', 'g#'
    stdout.must_match /1 row/
  end

  it 'with --mode option ANDs mode to search' do
    vimdb 'keys', 'gm', '-m=n'
    stdout.must_match /1 row/
  end

  describe "edge cases" do
    it "converts control key to C-" do
      vimdb 'keys', 'C-z'
      stdout.wont_match /0 rows/
      stdout.must_match /C-z/
    end

    it "converts escape key to E-" do
      vimdb 'keys', 'E-x'
      stdout.wont_match /0 rows/
      stdout.must_match /E-x/
    end

    it 'converts leader key to L-' do
      vimdb 'keys', 'L-z'
      stdout.must_match /1 row/
    end

    it 'searches non-alphabetic characters' do
      vimdb 'keys', '!'
      stdout.must_match /!\{filter\}/
    end

    it "lists plugin keys with plugin name" do
      vimdb 'keys'
      stdout.must_match /command-t plugin/
    end

    it 'lists user-generated keys' do
      vimdb 'keys', 'L-w'
      stdout.must_include <<-STR.sub(/^\s+/, '')
      | L-w | nvso | user | :call OpenURL()<CR> |
      STR
    end

    it "doesn't list Plug keys" do
      vimdb 'keys', 'Plug'
      stdout.must_match /0 rows/
    end

    it "doesn't list not used keys" do
      vimdb 'keys', '^not used$', '-f=desc', '-r'
      stdout.must_match /0 rows/
    end

    it "lists keys with description on following line" do
      vimdb 'keys', 'digraph', '-a'
      stdout.must_include <<-STR
| {char1}<BS>{char2}   | i    | default |  enter digraph (only when 'digraph' option set) |
STR
    end

    it "lists keys with no tabs and no description" do
      vimdb 'keys', 'C-r C-r'
      stdout.must_include <<-STR
| C-r C-r {0-9a-z"%#*:=}                 | i    | default |  insert the contents of a register literally               |
STR
    end

    it "lists keys with no tabs but a description" do
      vimdb 'keys', 'C-v {number}'
      stdout.must_include <<-STR
| C-v {number} | i    | default | insert three digit decimal number as a single byte. |
STR

      vimdb 'keys', 'C-w g C-]'
      stdout.must_include <<-STR
| C-w g C-] | n    | default | split window and do |:tjump| to tag under cursor |
      STR
    end
  end
end
