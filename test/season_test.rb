
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

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
  expected = ""
  actual = @stat_tracker.biggest_bust
  end

  def test_biggest_bust
  expected = ""
  actual = @stat_tracker.biggest_surprise
  end


  def test_winningest_coach_for_season
    expected = ""
    actual = @stat_tracker.winningest_coach
  end


  def test_worst_coach_for_season
    expected = ""
    actual = @stat_tracker.worst_coach
  end

  def test_most_accurate_team
    expected = ""
    actual = @stat_tracker.most_accurate_team
  end

  def test_least_accurate_team
    expected = ""
    actual = @stat_tracker.least_accurate_team
  end

  def test_most_hits
    expected = ""
    actual = @stat_tracker.most_hits
  end

  def test_fewest_hits
    expected = ""
    actual = @stat_tracker.fewest_hits
  end

  def test_power_play_goal_percentage
    expected = 0.0
    actual = @stat_tracker.power_play_goal_percentage
  end
end 
