require_relative 'test_helper'
require 'pry'
require './lib/game'
require './lib/stat_tracker'
require './lib/game_module'

class GameTest < Minitest::Test

    def setup
      locations = {
        games: './test/data/game.csv',
        teams: './test/data/team_info.csv',
        game_teams: './test/data/game_teams_stats.csv'
      }

      @stat_tracker = StatTracker.from_csv(locations)

    end

    def test_highest_total_score
      expected = 12
      assert_equal expected, @stat_tracker.highest_total_score
    end

    def test_lowest_total_score
      expected = 1
      assert_equal expected, @stat_tracker.lowest_total_score
    end

    def test_biggest_blowout
      expected = 5
      assert_equal expected, @stat_tracker.biggest_blowout
    end

    def test_percentage_home_wins
      expected = 53.68
      assert_equal expected, @stat_tracker.percentage_home_wins
    end

    def test_percentage_visitor_wins
      expected = 46.32
      assert_equal expected, @stat_tracker.percentage_visitor_wins
    end

    def test_count_of_games_by_season
      expected = {"20122013" => 44, "20152016" => 17, "20162017" => 17, "20172018" => 17}
      assert_equal expected, @stat_tracker.count_of_games_by_season
    end

    def test_average_goals_per_game
      expected = 5.74
      assert_equal expected, @stat_tracker.average_goals_per_game
    end

    def test_average_goals_by_season
      expected = {"20122013" => 5.0, "20152016" => 6.24, "20162017" => 6.53, "20172018" => 6.35}
      assert_equal expected, @stat_tracker.average_goals_by_season
    end
end
