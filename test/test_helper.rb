$:.unshift File.expand_path("../../lib", __FILE__)

ENV['RACK_ENV'] = 'test'
require 'simplecov' if ENV['COVERAGE']

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'active_record_helper'

class Minitest::Test
  def create_sample_exercise(language_name='ruby', slug='word-count')
    language = Language.find_or_create_by_name(language_name)
    type = ExerciseType.find_or_create_by_slug(slug)
    Exercise.create!(language: language, exercise_type: type)
  end
end

module Minitest::Alice

  def locales
    [
      Locale.new('ruby', 'rb', 'rb'),
      Locale.new('python', 'py', 'py')
    ]
  end

  def go
    @go ||= Language.create(name: 'go')
  end

  def ruby
    @ruby ||= Language.create(name: 'ruby')
  end

  def python
    @python ||= Language.create(name: 'python')
  end

  def clojure
    @clojure ||= Language.create(name: 'clojure')
  end

  def go
    @go ||= Language.create(name: 'go')
  end


  def hypothesis
    @hypothesis ||= ExerciseType.create!(slug: 'hypothesis')
  end

  def ruby_button
    @ruby_button ||= Exercise.create!(language: ruby, exercise_type: ExerciseType.create(slug: 'button'))
  end

  def ruby_hypothesis
    @ruby_hypothesis ||= Exercise.create!(language: ruby, exercise_type: hypothesis)
  end

  def python_tissue
    @python_trail ||= Exercise.create!(language: python, exercise_type: ExerciseType.create(slug: 'tissue'))
  end

  def python_eggs
    @python_trail ||= Exercise.create!(language: python, exercise_type: ExerciseType.create(slug: 'eggs'))
  end

  def ruby_tree
    @ruby_tree ||= Exercise.create!(language: ruby, exercise_type: ExerciseType.create(slug: 'tree'))
  end

  def go_light
    @go_light ||= Exercise.create!(language: go, exercise_type: ExerciseType.create(slug: 'light'))
  end

  def python_gyroscope
    @python_gyroscope ||= Exercise.create!(language: python, exercise_type: ExerciseType.create(slug: 'gyroscope'))
  end

  def alice
    @alice ||= begin
      alice = User.create(username: 'alice')

      alice.user_exercises.create!(exercise: ruby_button, completed: false)
      alice.user_exercises.create!(exercise: python_eggs, completed: false)
      alice.user_exercises.create!(exercise: go_light, completed: false)

      alice.user_exercises.create!(exercise: ruby_hypothesis, completed: true)
      alice.user_exercises.create!(exercise: ruby_tree, completed: true)
      alice.user_exercises.create!(exercise: python_gyroscope, completed: true)
      alice
    end
  end
end
