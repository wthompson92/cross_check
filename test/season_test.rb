require 'minitest/autorun'
require 'minitest/pride'
require './lib/season'

class SeasonTest < Minitest:: Test
  def setup
    @season = Season.new
  end

  def test_it_exists
    expected = Season
    actual = @season
  end

  def test_team_biggest_decrease_bt_reg_and_postseason
    expected = string
    actual = @season.biggest_bust
    assert_equal expected, actual
  end

  def test_team_biggest_increase_bt_reg_and_postseason
    expected = string
    actual = @season.biggest_surprise
    assert_equal expected, actual
  end

  def test_winningest_and_worst_coach
    expected = string
    actual = @season.winningest_coach
    assert_equal expected, actual

    expected = int
    actual = @season.worst_coach
    assert_equal expected, actual
  end

  def test_most_and_least_accurate_team
    expected = string
    actual = @season.most_accurate_team
    assert_equal expected, actual

    expected = string
    actual = @season.least_accurate_team
    assert_equal expected, actual
  end

  def test_most_and_fewest_hits
    actual = string
    expected = @season.most_hits
    assert_equal expected, actual

    actual = string
    expected = @season.fewest_hits
    assert_equal expected, actual
  end

  def test_power_play_goal_percentage
    expected = float
    actual = @season.power_play_goal_percentage
    assert_equal expected, actual
  end
end
