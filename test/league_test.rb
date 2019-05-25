require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class LeagueTest < Minitest::Test

    def setup
      locations = {
        games: 'test/data/game.csv',
        teams: 'test/data/team_info.csv',
        game_teams: 'test/data/game_teams_stats.csv'
      }
      @stat_tracker = StatTracker.from_csv(locations)
    end

  def test_it_exists
    expected = StatTracker
    actual = @stat_tracker
    assert_instance_of expected, actual
  end

  def test_league_winningest_team
    assert_equal "", @stat_tracker.winningest_team
  end
      #
      # def test_fan_methods
      #   assert_equal "", @stat_tracker.best_fans
      #   assert_equal [], @stat_tracker.worst_fans
      # end
end
