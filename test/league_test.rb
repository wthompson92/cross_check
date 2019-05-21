require 'minitest/autorun'
require 'minitest/pride'
require '/.lib/league'

class LeagueTest < Minitest:: Test
  def setup
    @league = League.new
  end

  def test_it_exists
    expected = League
    actual = @League
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

  def test_highest_scoring_methods
    expected = string
    actual = @league.highest_scoring_visitor
    assert_equal expected, actual

    expected = string
    actual = @leauge.highest_scoring_home_team
    assert_equal expected, actual
  end

  def test_lowest_scoring_methods
    expected = string
    actual = @league.lowest_scoring_visitor
    assert_equal expected, actual

    expected = string
    actual = @league.lowest_home_team
    assert_equal expected, actual
  end

  def test_league_winningest_team
    actual = string
    expected = @league.winningest_team
    assert_equal expected, actual
  end

  def test_fan_methods
    expected = string
    actual = @league.best_fans
    assert_equal expected, actual

    expected = array
    actual = @league.worst_fans
    assert_equal expected, actual
  end
end
