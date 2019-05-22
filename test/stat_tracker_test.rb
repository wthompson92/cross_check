require_relative 'test_helper'
require 'csv'
require 'pry'
require './lib/game'
require './lib/stat_tracker'
require './lib/game_module'

class StatTrackerTest < Minitest::Test

    def setup
      locations = {
        games: './test/data/game.csv',
        teams: './test/data/team_info.csv',
        game_teams: './test/data/game_teams_stats.csv'
      }

      @stat_tracker = StatTracker.from_csv(locations)

    end

    def test_it_exists
      assert_instance_of StatTracker, @stat_tracker
    end


    def test_attributes
      assert_equal @stat_tracker.games.first.away_team_id, 3
      assert_equal @stat_tracker.games.first.home_team_id, 6
      assert_equal @stat_tracker.games.first.outcome, "home win OT"
      assert_equal @stat_tracker.games.first.game_id, "2012030221"
    end

end
