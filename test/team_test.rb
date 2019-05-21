require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'

class TeamTest < Minitest:: Test
  def setup
    @team = Team.new
  end

  def test_it_exists
    expected = Team
    actual = @team
  end

  def test_team_attributes
    expected = hash
    actual = @team.team_info
    assert_equal expected, actual
  end

  def test_highest_and_lowest_win_percentage
    expected = int
    actual = @team.best_season
    assert_equal expected, actual

    expected = int
    actual = @team.worst_season
    assert_equal expected, actual
  end

  def test_average_win_percentage_all_games
    expected = float
    actual = @team.average_win_percentage
    assert_equal expected, actual
  end

  def test_most_and_fewest_goals_scored
    expected = int
    actual = @team.most_goals_scored
    assert_equal expected, actual

    expected = int
    actual = @team.fewest_goals_scored
    assert_equal expected, actual
  end

  def test_opponent_with_lowest_and_highest_win_percentage
    expected = string
    actual = @team.favorite_opponent
    assert_equal expected, actual

    expected = string
    actual = @team.rival
    assert_equal expected, actual
  end

  def test_biggest_difference_in_scroring
    actual = int
    expected = @team.biggest_team_blowout
    assert_equal expected, actual

    actual = int
    expected = @team.worst_loss
    assert_equal expected, actual
  end

  def test_head_to_head_for_all_oponents
    expected = hash
    actual = @team.head_to_head
    assert_equal expected, actual
  end

  def test_seasonal_summary
    expected = hash
    actual = @team.seasonal_summary
    assert_equal expected, actual
  end
end
