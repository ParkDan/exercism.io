class Language < ActiveRecord::Base
  validates :name, presence: true

  before_save do
    set_display_name_from_name
  end

  def to_s
    display_name
  end

  private

  def set_display_name_from_name
    self.display_name = name.split('-').map(&:capitalize).join(' ')
  end
end
