
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
    binding.pry
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
    expected = "Paul MacLean"
    actual = @stat_tracker.winningest_coach("20122013")

    assert_equal expected, actual
  end


  def test_worst_coach_for_season
    expected = "Dan Bylsma"
    actual = @stat_tracker.worst_coach("20122013")

    assert_equal expected, actual
  end

  def test_most_accurate_team
    expected = "Capitals"
    actual = @stat_tracker.most_accurate_team("20172018")

    assert_equal expected, actual
  end

  def test_least_accurate_team
    expected = "Panthers"
    actual = @stat_tracker.least_accurate_team("20172018")

    assert_equal expected, actual
  end

  def test_most_hits
    expected = "Kings"
    actual = @stat_tracker.most_hits("20172018")

    assert_equal expected, actual
  end

  def test_fewest_hits
    expected = "Islanders"
    actual = @stat_tracker.fewest_hits("20172018")

    assert_equal expected, actual
  end

  def test_power_play_goal_percentage
    expected = 16.67
    actual = @stat_tracker.power_play_goal_percentage("20152016")

    assert_equal expected, actual
  end

  def test_find_games_in_game_teams_by_season

    assert_equal " ", @stat_tracker.find_games_in_game_teams_by_season("20172018").count
  end
end
