require_relative 'test_helper'
require 'csv'
require 'pry'
require './lib/game'
require './lib/stat_tracker'
require './lib/game_module'

class GameTest < Minitest::Test

  def setup
    locations = {
      games: './data/game_dummy.csv',
      teams: './data/team_info_dummy.csv',
      game_teams: './data/game_teams_stats_dummy.csv'
    }

    @stat_tracker = StatTracker.from_csv(locations)

  end

  def test_highest_total_score
    expected = 10
    assert_equal expected, @stat_tracker.highest_total_score
  end

#   def test_lowest_total_score
#     expected = int
#     assert_equal expected, @stat_tracker.lowest_total_score
#   end
#
#   def test_biggest_blowout
#     expected = int
#     assert_equal expected, biggest_blowout
#   end
#
#   def test_percentage_home_wins
#     expected = float
#     assert_equal expected, @stat_tracker.percentage_home_wins
#   end
#
#   def test_percentage_visitor_wins
#     expected = float
#     assert_equal expected, @stat_tracker.percentage_visitor_wins
#   end
#
#   def test_count_of_games_by_season
#     expected = hash
#     assert_equal expected, @stat_tracker.count_of_games_by_season
#   end
#
#   def test_average_goals_per_game
#     expected = float
#     assert_equal expected, @stat_tracker.average_goals_per_game
#   end
#
#   def test_average_goals_by_season
#     expected = hash
#     assert_equal expected, @stat_tracker.average_goals_by_season
#   end
end
