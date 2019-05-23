require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/stat_tracker'


class TeamTest < Minitest:: Test

    def setup
      locations = {
        games: './test/data/game.csv',
        teams: './test/data/team_info.csv',
        game_teams: './test/data/game_teams_stats.csv'
      }
      @stat_tracker = StatTracker.from_csv(locations)

    end


    def test_team_info

      expected = {
          "team_id" => "1",
          "franchise_id" => "23",
          "short_name" => "New Jersey",
          "team_name" => "Devils",
          "abbreviation" => "NJD",
          "link" => "/api/v1/teams/1" }

      assert_equal expected, @stat_tracker.team_info("1")
    end

    def test_seasonal_summary
      expected = {"20162017" => { => "2"}}
      assert_equal expected, @stat_tracker.seasonal_summary("3")
    end
end
