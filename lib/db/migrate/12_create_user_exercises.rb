class CreateUserExercises < ActiveRecord::Migration
  def change
    create_table :user_exercises do |t|
      t.integer :user_id, null: false
      t.integer :exercise_id, null: false
      t.boolean :completed, null: false
    end
  end
end
