require_relative 'test_helper'
require 'pry'
require './lib/game'
require './lib/stat_tracker'
require './lib/game_module'

class GameTest < Minitest::Test

    def setup
      locations = {
        games: '/test/data/game.csv',
        teams: '/test/data/team_info.csv',
        game_teams: '/test/data/game_teams_stats.csv'
      }


      @stat_tracker = StatTracker.from_csv(locations)

    end

    def test_highest_total_score
      expected = 11
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
      expected = 50.0
      assert_equal expected, @stat_tracker.percentage_home_wins
    end

    def test_percentage_visitor_wins
      expected = 50.0
      assert_equal expected, @stat_tracker.percentage_visitor_wins
    end

    def test_count_of_games_by_season
      expected = {"20122013" => 9, "20142015"=>11}
      assert_equal expected, @stat_tracker.count_of_games_by_season
    end

    def test_average_goals_per_game
      expected = 5.25
      assert_equal expected, @stat_tracker.average_goals_per_game
    end

    def test_average_goals_by_season
      expected = {"20122013" => 5.11, "20142015"=>5.36}
      assert_equal expected, @stat_tracker.average_goals_by_season
    end
end
