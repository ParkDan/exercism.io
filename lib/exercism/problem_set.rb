module ProblemSet
  def doing?(language)
    user_exercises.current.joins(:exercise).
      where("exercises.language_id" => language.id).exists?
  end

  def did?(language)
    user_exercises.completed.joins(:exercise).
      where("exercises.language_id" => language.id).exists?
  end

  def current_exercises
    @current_exercises ||= user_exercises.current.map(&:exercise)
  end

  def completed_exercises
    @completed_exercises ||= user_exercises.completed.map(&:exercise)
  end

  def completed?(exercise)
    user_exercises.completed.where(exercise_id: exercise.id).exists?
  end

  def working_on?(candidate)
    current_exercises.any? {|exercise| exercise == candidate}
  end

  def current_languages
    language_ids = user_exercises.current.joins(:exercise).
      select("DISTINCT(language_id) as language_id").map(&:language_id)
    Language.where(id: language_ids)
  end

  def current_in(language)
    user_exercise = user_exercises.current.joins(:exercise).
      where('exercises.language_id' => language.id).last

    user_exercise ? user_exercise.exercise : nil
  end

  def latest_in(language)
    user_exercise = user_exercises.completed.joins(:exercise).
      where('exercises.language_id' => language.id).last

    user_exercise ? user_exercise.exercise : nil
  end
end
