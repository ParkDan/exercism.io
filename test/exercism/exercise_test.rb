require './test/test_helper'
require 'exercism/exercise'

class ExerciseTest < Minitest::Test
  def test_exercise_in_p
    go = Language.create name: 'go'
    clojure = Language.create name: 'clojure'
    exercise_type =  ExerciseType.create(slug: 'one')
    exercise = Exercise.create(language: go, exercise_type: exercise_type)

    assert exercise.in?(go)
    refute exercise.in?(clojure)
  end

  def test_exercise_to_s
    clojure = Language.create name: 'clojure'
    exercise_type =  ExerciseType.create(slug: 'one')
    exercise = Exercise.create(language: clojure, exercise_type: exercise_type)
    assert_equal 'Exercise: one (Clojure)', exercise.to_s
  end
end


