require './test/test_helper'
require 'exercism/exercise'
require 'exercism/problem_set'

class ProblemSetTest < Minitest::Test
  include Minitest::Alice

  #def current
  #  {'ruby' => 'button', 'python' => 'eggs', 'go' => 'light'}

  #def completed
  #  {'ruby' => ['shoe', 'lion'], 'python' => ['ham']}

  def test_doing
    assert alice.doing?(ruby)
    assert alice.doing?(python)
    assert alice.doing?(go)
    refute alice.doing?(clojure)
  end

  def test_did
    assert alice.did?(ruby)
    assert alice.did?(python)
    refute alice.did?(go)
  end

  def test_current_exercises
    ruby, python, go = alice.current_exercises
    assert_equal ruby_button, ruby
    assert_equal python_eggs, python
    assert_equal go_light, go
  end

  def test_completed_exercises
    shoe, lion = alice.completed_exercises['ruby']
    ham = alice.completed_exercises['python'].first
    assert_equal create_sample_exercise('ruby', 'shoe'), shoe
    assert_equal create_sample_exercise('ruby', 'lion'), lion
    assert_equal create_sample_exercise('python', 'ham'), ham
  end

  def test_completed_p
    assert alice.completed?(create_sample_exercise('ruby', 'shoe')), 'shoe'
    assert alice.completed?(create_sample_exercise('ruby', 'lion')), 'lion'
    refute alice.completed?(create_sample_exercise('ruby', 'button')), 'button'
    refute alice.completed?(create_sample_exercise('ruby', 'pill')), 'pill'
  end

  def test_working_on_p
    assert alice.working_on?(create_sample_exercise('ruby', 'button')), 'button'
    refute alice.working_on?(create_sample_exercise('ruby', 'shoe')), 'shoe'
  end

  def test_current_languages
    assert_equal %w(go python ruby), alice.current_languages.sort
  end

  def test_current_exercise_in_language
    assert_equal ruby_button, alice.current_in(ruby)
  end

  def test_latest_in_language
    ham = create_sample_exercise('python', 'ham')
    assert_equal ham, alice.latest_in(python)

    lion = create_sample_exercise('ruby', 'lion')
    assert_equal lion, alice.latest_in(ruby)

    assert_nil alice.latest_in(haskell)
  end
end

