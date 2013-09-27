class CreateExerciseTypes < ActiveRecord::Migration
  def change
    create_table :exercise_types do |t|
      t.string :slug, null: false
      t.string :name, null: false
    end
  end
end



