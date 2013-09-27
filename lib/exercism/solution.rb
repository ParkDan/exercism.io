class Exercism
  class UnavailableExercise < StandardError; end
end

class Solution
  attr_reader :user, :code
  def initialize(user, code)
    @user, @code = user, code
  end

  def exercise
    @exercise ||= begin
      begin
        exercise = Exercise.where(language_id: language.id, exercise_type_id: exercise_type.id).first!
        validate(exercise)
        exercise
      rescue ActiveRecord::RecordNotFound
        raise Exercism::UnavailableExercise.new("This exercise")
      end
    end
  end

  private

  def language
    @language ||= Language.where(name: code.language).first!
  end

  def exercise_type
    @exercise_type ||= begin
      slug = code.slug || user.current_in(language).slug
      ExerciseType.where(slug: slug).first!
    end
  end

  def available?(exercise)
    current = user.current_in(exercise.language)
    !current || current.slug == exercise.slug || user.completed?(exercise)
  end

  def validate(candidate)
    unless available?(candidate)
      raise Exercism::UnavailableExercise.new(error_message(candidate))
    end
  end

  def error_message(candidate)
    "#{candidate} has not been unlocked for you yet. You may only submit exercises that you've previously completed, or which are listed as current in your exercism account."
  end
end
