class ExerciseType < ActiveRecord::Base

  validate :slug, presence: true

  before_save do
    set_name_from_slug
  end

  private

  def set_name_from_slug
    self.name = slug.split('-').map(&:capitalize).join(' ')
  end
end

