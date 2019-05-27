require_relative 'test_helper'
require 'pry'
require './lib/game'
require './lib/stat_tracker'
require './lib/game_module'

class GameTest < Minitest::Test

    def setup
      locations = {
        games: './data/game.csv',
        teams: './data/team_info.csv',
        game_teams: './data/game_teams_stats.csv'
      }
      @stat_tracker = StatTracker.from_csv(locations)

    end

    def test_highest_total_score
      assert_equal 15, @stat_tracker.highest_total_score
    end

    def test_lowest_total_score
      assert_equal 1, @stat_tracker.lowest_total_score
    end

    def test_biggest_blowout
      assert_equal 10, @stat_tracker.biggest_blowout
    end

    def test_percentage_home_wins
      assert_equal 0.55, @stat_tracker.percentage_home_wins
    end

    def test_percentage_visitor_wins
      assert_equal 0.45, @stat_tracker.percentage_visitor_wins
    end

    def test_count_of_games_by_season
      expected = {"20122013"=>806,
         "20162017"=>1317,
         "20142015"=>1319,
         "20152016"=>1321,
         "20132014"=>1323,
         "20172018"=>1355}
      assert_equal expected, @stat_tracker.count_of_games_by_season
    end

    def test_average_goals_per_game
      assert_equal 5.54, @stat_tracker.average_goals_per_game
    end

    def test_average_goals_by_season
      expected = {
         "20122013"=>5.4,
         "20162017"=>5.51,
         "20142015"=>5.43,
         "20152016"=>5.41,
         "20132014"=>5.5,
         "20172018"=>5.94 }
      assert_equal expected, @stat_tracker.average_goals_by_season
    end
end
