require './test/api_helper'

class StashesApiTest < Minitest::Test
  include Rack::Test::Methods

  def app
    ExercismAPI
  end

  attr_reader :alice
  def setup
    super
    @alice = User.create(username: 'alice', github_id: 1, current: {'ruby' => 'word-count', 'javascript' => 'anagram'})
  end

  def test_api_accepts_stash_submission_and_returns_stash_file
    post '/user/assignments/stash', {key: alice.key, code: 'THE CODE', filename: 'code.rb'}.to_json
    assert_equal 201, last_response.status

    get '/user/assignments/stash', {key: alice.key, filename: 'code.rb'}
    assert_equal 200, last_response.status
    assert_equal({"code" => 'THE CODE', "filename" => "code.rb"}, JSON::parse(last_response.body))
  end

  def test_api_requires_user_key_on_get_stash_file
    get '/user/assignments/stash'
    assert_equal 401, last_response.status
  end

  def test_api_requires_key_on_stash_submission
    post '/user/assignments/stash', {code: 'THE CODE', filename: 'code.rb'}.to_json
    assert_equal 401, last_response.status
  end

  def test_api_returns_stash_list
    post '/user/assignments/stash', {key: alice.key, code: 'THE CODE', filename: 'code.rb'}.to_json
    get '/user/assignments/stash/list', {key: alice.key}
    assert_equal({"list" => ["code.rb"]}, JSON::parse(last_response.body))
    assert_equal 200, last_response.status
  end

  def test_stash_deleted_on_submission_attempt
    post '/user/assignments/stash', {key: alice.key, code: 'THE CODE', filename: 'code.rb'}.to_json
    post '/user/assignments', {key: alice.key, code: 'THE CODE', path: 'code.rb'}.to_json
    get '/user/assignments/stash/list', {key: alice.key}
    assert_equal({"list" => []}, JSON::parse(last_response.body))
  end
end
