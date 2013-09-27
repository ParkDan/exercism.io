class UserExercise < ActiveRecord::Base

  belongs_to :user
  belongs_to :exercise

  validates :user, presence: true
  validates :exercise, presence: true

  scope :current, -> { where(completed: false) }
  scope :completed, -> { where(completed: true) }

  before_create do
    self.completed ||= false
    true
  end

end
