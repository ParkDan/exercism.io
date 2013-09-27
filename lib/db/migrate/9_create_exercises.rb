class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.integer :language_id,      null: false
      t.integer :exercise_type_id, null: false
    end
  end
end


