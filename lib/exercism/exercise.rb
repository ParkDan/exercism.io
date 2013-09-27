class Exercise < ActiveRecord::Base
  belongs_to :language
  belongs_to :exercise_type
  
  validates :language, presence: true
  validates :exercise_type_id, presence: true, uniqueness: {scope: :language_id}

  def self.for(language, slug)
    where(language: language, slug: slug)
  end

  def in?(other_language)
    language == other_language
  end

  def to_s
    "Exercise: #{slug} (#{language.display_name})"
  end

  def slug
    exercise_type.slug
  end

end
