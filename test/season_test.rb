
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class SeasonTest < Minitest::Test

  def setup
    locations = {
      games: './test/data/game.csv',
      teams: './data/team_info.csv',
      game_teams: './test/data/game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(locations)

  end

  def test_biggest_bust
    expected = "Senators"
    actual = @stat_tracker.biggest_bust("20172018")

    assert_equal expected, actual
  end

  def test_biggest_surprise
    expected = "Devils"
    actual = @stat_tracker.biggest_surprise("20172018")

    assert_equal expected, actual
  end

  def test_winningest_coach_for_season
    skip
    expected = "Paul MacLean"
    actual = @stat_tracker.winningest_coach("20122013")

    assert_equal expected, actual
  end


  def test_worst_coach_for_season
    skip
    expected = "Dan Bylsma"
    actual = @stat_tracker.worst_coach("20122013")

    assert_equal expected, actual
  end

  def test_most_accurate_team
    skip
    expected = "Capitals"
    actual = @stat_tracker.most_accurate_team("20172018")

    assert_equal expected, actual
  end

  def test_least_accurate_team
    skip
    expected = "Panthers"
    actual = @stat_tracker.least_accurate_team("20172018")

    assert_equal expected, actual
  end

  def test_most_hits
    skip
    expected = "Kings"
    actual = @stat_tracker.most_hits("20172018")

    assert_equal expected, actual
  end

  def test_fewest_hits
    skip
    expected = "Islanders"
    actual = @stat_tracker.fewest_hits("20172018")

    assert_equal expected, actual
  end

  def test_power_play_goal_percentage
    skip
    expected = 16.67
    actual = @stat_tracker.power_play_goal_percentage("20152016")

    assert_equal expected, actual
  end

  def test_find_games_in_game_teams_by_season
    expected = 14
    actual = @stat_tracker.find_games_in_game_teams_by_season("20172018").count
    assert_equal expected, actual
  end

  def test_shots_by_season
    expected = ["30", 27]
    actual = @stat_tracker.shots_by_season("20172018").first
    assert_equal expected, actual
  end

  def test_shots_by_season
    expected = ["30", 4]
    actual = @stat_tracker.goals_by_season("20172018").first
    assert_equal expected, actual
  end

  def test_accuracy_by_team_by_season
    expected = ["30", 0.14814814814814814]
    actual = @stat_tracker.accuracy_by_team_by_season("20172018").first
    assert_equal expected, actual
  end

  def test_hits_per_game_per_season
    expected = ["30", 28]
    actual = @stat_tracker.hits_per_game_per_season("20172018").first
    assert_equal expected, actual
  end

end
