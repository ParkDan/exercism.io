require './test/test_helper'
require 'exercism/exercise'
require 'exercism/locale'
require 'exercism/code'
require 'exercism/problem_set'
require 'exercism/solution'

class SolutionTest < Minitest::Test

  include Minitest::Alice

  def test_identify_current_exercise
    code = Code.new('/some/path/button/file.rb', locales)
    solution = Solution.new(alice, code)
    assert_equal ruby_button, solution.exercise
  end

  def test_identify_available_exercise_on_unstarted_trail
    python_tissue
    code = Code.new('/some/path/tissue/file.py', locales)
    solution = Solution.new(alice, code)
    assert_equal python_tissue, solution.exercise
  end

  def test_assume_current_exercise
    code = Code.new('file.rb', locales)
    solution = Solution.new(alice, code)
    assert_equal ruby_button, solution.exercise
  end

  def test_identify_completed_exercise
    code = Code.new('/some/path/hypothesis/file.rb', locales)
    solution = Solution.new(alice, code)
    assert_equal ruby_hypothesis, solution.exercise
  end

  def test_blows_up_on_future_exercise
    code = Code.new('/some/path/goat/file.rb', locales)
    solution = Solution.new(alice, code)
    assert_raises Exercism::UnavailableExercise do
      solution.exercise
    end
  end

end

