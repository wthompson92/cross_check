
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class SeasonTest < Minitest::Test
  def setup
    locations = {
      games: 'test/data/game.csv',
      teams: 'test/data/team_info.csv',
      game_teams: 'test/data/game_teams_stats.csv'
      }
    @stat_tracker = StatTracker.from_csv(locations)

  end

  def test_biggest_bust
    expected = "Canadiens"
    actual = @stat_tracker.biggest_bust("20122013")
    assert_equal expected, actual
  end

  def test_biggest_surprise
    expected = "Lightning"
    actual = @stat_tracker.biggest_surprise("20122013")
    assert_equal expected, actual
  end

  def test_winningest_coach_for_season
    skip
    expected = ""
    actual = @stat_tracker.winningest_coach("2012030221")
    assert_equal expected, actual
  end


  def test_worst_coach_for_season
    skip
    expected = ""
    actual = @stat_tracker.worst_coach("2012030221")
    assert_equal expected, actual
  end

  def test_most_accurate_team
    skip
    expected = ""
    actual = @stat_tracker.most_accurate_team("2012030221")
    assert_equal expected, actual
  end

  def test_least_accurate_team
    skip
    expected = ""
    actual = @stat_tracker.least_accurate_team("2012030221")
    assert_equal expected, actual
  end

  def test_most_hits
    skip
    expected = ""
    actual = @stat_tracker.most_hits("2012030221")
    assert_equal expected, actual
  end

  def test_fewest_hits
    skip
    expected = ""
    actual = @stat_tracker.fewest_hits("2012030221")
    assert_equal expected, actual
  end

  def test_power_play_goal_percentage
    skip
    expected = 0.0
    actual = @stat_tracker.power_play_goal_percentage("2012030221")
    assert_equal expected, actual
  end
end
