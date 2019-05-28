
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class SeasonTest < Minitest::Test

  def setup
    locations = {
      games: './data/game.csv',
      teams: './data/team_info.csv',
      game_teams: './data/game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(locations)

  end

  def test_biggest_bust
    expected = "Senators"
    actual = @stat_tracker.biggest_bust("20122013")
    assert_equal expected, actual
  end

  def test_biggest_surprise
    expected = "Devils"
    actual = @stat_tracker.biggest_surprise("20122013")
    assert_equal expected, actual
  end

  def test_winningest_coach_for_season
    expected = "Dan Lacroix"
    actual = @stat_tracker.winningest_coach("20122013")
    assert_equal expected, actual
  end


  def test_worst_coach_for_season
    expected = "Kevin Dineen"
    actual = @stat_tracker.worst_coach("20122013")
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
  # def test_biggest_bust
  #   expected = ""
  #   actual = @stat_tracker.biggest_bust()
  #   assert_equal expected, actual
  # end
  #
  # def test_biggest_bust
  #   expected = ""
  #   actual = @stat_tracker.biggest_surprise
  #   assert_equal expected, actual
  #
  # end
  #
  #
  # def test_winningest_coach_for_season
  #   expected = ""
  #   actual = @stat_tracker.winningest_coach
  #   assert_equal expected, actual
  # end
  #
  #
  # def test_worst_coach_for_season
  #   expected = ""
  #   actual = @stat_tracker.worst_coach
  #   assert_equal expected, actual
  # end
  #
  # def test_most_accurate_team
  #   expected = ""
  #   actual = @stat_tracker.most_accurate_team
  #   assert_equal expected, actual
  # end
  #
  # def test_least_accurate_team
  #   expected = ""
  #   actual = @stat_tracker.least_accurate_team
  #   assert_equal expected, actual
  # end
  #
  # def test_most_hits
  #   expected = ""
  #   actual = @stat_tracker.most_hits
  #   assert_equal expected, actual
  # end
  #
  # def test_fewest_hits
  #   expected = ""
  #   actual = @stat_tracker.fewest_hits
  #   assert_equal expected, actual
  # end
  #
  # def test_power_play_goal_percentage
  #   expected = 0.0
  #   actual = @stat_tracker.power_play_goal_percentage
  #   assert_equal expected, actual
  # end
end
