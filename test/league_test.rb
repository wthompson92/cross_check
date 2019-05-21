require 'minitest/autorun'
require 'minitest/pride'
require 'league'

class LeaugeTest < Minitest:: Test
  def setup
  end

  def test_it_exists
  end

  def test_number_of_teams_in_League
    expected = int
    actual = @league.count_of_teams
    assert_equal expected, actual
  end

  def test_leauge_offence_data
    expected = string
    actual = @league.best_offense
    assert_equal expected, actual
    expected = string
    actual = @league.worst_offense
    assert_equal expected, actual
  end

  def test_leauge_defense_data
    expected = string
    actual = @league.best_defense
    assert_equal expected, actual
    expected = string
    actual = @league.worst_defense 
    assert_equal expected, actual
  end
end
