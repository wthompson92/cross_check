require_relative 'test_helper'
require 'csv'
require 'pry'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/team_module'
require './lib/stat_tracker'

class TeamTest < Minitest::Test

  def setup
    locations = {
      games: './test/data/game.csv',
      teams: './test/data/team_info.csv',
      game_teams: './test/data/game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_team_by_id
    assert_equal @stat_tracker.teams.first, @stat_tracker.team_by_id(1)
  end

  def test_team_attributes
    expected = { "team_id" => 1,
      "franchise_id" => 23,
      "short_name" => "New Jersey",
      "team_name" => "Devils",
      "abbreviation" => "NJD",
      "link" => "/api/v1/teams/1" }
    assert_equal expected, @stat_tracker.team_info(1)
  end

  def test_games_played_by_team_id
    assert_equal 6, @stat_tracker.games_played("6").count
  end

  def test_total_seasons
    assert_equal 2, @stat_tracker.total_seasons("6").count

  end

  # def test_win_perc_by_season
  #   seasons = @stat_tracker.total_seasons("6")
  #   games = @stat_tracker.games_played("6")
  #   actual = @stat_tracker.win_perc_by_season(seasons, games, "6")
  #   assert_equal
  #   assert_equal
  # end

  def test_highest_and_lowest_win_percentage
    assert_equal 20122013, @stat_tracker.best_season("6")
    assert_equal 20162017, @stat_tracker.worst_season("6")
  end

  # def test_average_win_percentage_all_games
  #   assert_equal 0.0, @stat_tracker.average_win_percentage
  # end
  #
  # def test_most_and_fewest_goals_scored
  #   assert_equal 0, @stat_tracker.most_goals_scored
  #   assert_equal 0, @stat_tracker.fewest_goals_scored
  # end
  #
  def test_opponent_with_lowest_and_highest_win_percentage
    assert_equal "something", @stat_tracker.favorite_opponent(team_id)
    assert_equal "something", @stat_tracker.rival
  end

  # def test_biggest_difference_in_scoring
  #   assert_equal 0, @stat_tracker.biggest_team_blowout
  #   assert_equal 0, @stat_tracker.worst_loss
  # end

  # def test_head_to_head_for_all_oponents
  #   assert_equal {key: value}, @stat_tracker.head_to_head
  # end
  #
  # def test_seasonal_summary
  #   assert_equal {key: value}, @stat_tracker.seasonal_summary
  # end

end
