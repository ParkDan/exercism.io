require './test/test_helper'
require 'exercism/exercise'

class ExerciseTypeTest < Minitest::Test

  def test_name
    exercise_type = ExerciseType.create(slug: 'one')
    assert_equal 'One', exercise_type.name
  end

  def test_compound_exercise_name
    exercise_type = ExerciseType.create(slug: 'one-and-two')
    assert_equal 'One And Two', exercise_type.name
  end

end
