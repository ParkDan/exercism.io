require './test/test_helper'
require 'exercism/exercise'

class LanguageTest < Minitest::Test
  def test_to_s
    name = "Foobar"
    language = Language.create(name: name)
    assert_equal name, language.to_s
  end
end
