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
    expected = @stat_tracker.teams.first
    actual = @stat_tracker.team_by_id(1)

    assert_equal expected, actual
  end

  def test_team_attributes
    expected = { "team_id" => 1,
      "franchise_id" => 23,
      "short_name" => "New Jersey",
      "team_name" => "Devils",
      "abbreviation" => "NJD",
      "link" => "/api/v1/teams/1" }

    actual = @stat_tracker.team_info(1)
    assert_equal expected, actual
  end

  def test_games_played_by_team_id
    expected = 9
    actual = @stat_tracker.games_played(6).count

    assert_equal expected, actual
  end

  def test_total_seasons
    expected = 2
    actual = @stat_tracker.total_seasons(6).count

    assert_equal expected, actual
  end

  def test_win_perc_by_season
    seasons = @stat_tracker.total_seasons(6)
    games = @stat_tracker.games_played(6)

    actual = @stat_tracker.win_perc_by_season(seasons, games, 6)
    assert_equal 80, actual[20132014]
    assert_equal 100, actual[20122013]
  end

  def test_highest_and_lowest_win_percentage

    assert_equal 20122013, @stat_tracker.best_season(6)

    assert_equal 20132014, @stat_tracker.worst_season(6)
  end

  def test_average_win_percentage_all_games
    skip
    expected = float
    actual = @stat_tracker.average_win_percentage
    assert_equal expected, actual
  end

  def test_most_and_fewest_goals_scored
    skip
    expected = int
    actual = @stat_tracker.most_goals_scored
    assert_equal expected, actual

    expected = int
    actual = @stat_tracker.fewest_goals_scored
    assert_equal expected, actual
  end

  def test_opponent_with_lowest_and_highest_win_percentage
    skip
    expected = string
    actual = @stat_tracker.favorite_opponent
    assert_equal expected, actual

    expected = string
    actual = @stat_tracker.rival
    assert_equal expected, actual
  end

  def test_biggest_difference_in_scoring
    skip
    actual = int
    expected = @stat_tracker.biggest_team_blowout
    assert_equal expected, actual

    actual = int
    expected = @stat_tracker.worst_loss
    assert_equal expected, actual
  end

  def test_head_to_head_for_all_oponents
    skip
    expected = hash
    actual = @stat_tracker.head_to_head
    assert_equal expected, actual
  end

  def test_seasonal_summary
    skip
    expected = hash
    actual = @stat_tracker.seasonal_summary
    assert_equal expected, actual
  end
end
