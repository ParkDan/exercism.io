require './test/integration_helper'

class BreakdownTest < Minitest::Test

  def setup
    skip
  end

  def teardown
    super
    @alice = nil
  end

  def alice
    @alice ||= User.create(username: 'alice')
  end

  def test_simple_breakdown
    Submission.create(user: alice, language: 'ruby', slug: 'bob')
    Submission.create(user: alice, language: 'ruby', slug: 'bob')
    Submission.create(user: alice, language: 'ruby', slug: 'word-count')
    Submission.create(user: alice, language: 'python', slug: 'bob')
    Submission.create(user: alice, language: 'python', slug: 'word-count')

    bob = create_sample_exercise('ruby', 'bob')
    word_count = create_sample_exercise('ruby', 'word-count')
    whatever = create_sample_exercise('ruby', 'whatever')

    breakdown = Breakdown.of('ruby')
    assert_equal 2, breakdown[bob]
    assert_equal 1, breakdown[word_count]
    assert_equal 0, breakdown[whatever]
  end

end
