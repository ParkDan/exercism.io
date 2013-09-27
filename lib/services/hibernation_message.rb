class HibernationMessage < Message

  def subject
    "Your #{exercise.language.name} #{exercise.exercise_type.slug} submission went into hibernation"
  end

  def template_name
    'hibernation'
  end

  def from_email
    'katrina.owen@gmail.com'
  end

end
