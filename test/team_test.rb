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
    # binding.pry
  end

  def test_team_attributes
    expected = { "team_id" => "1",
      "franchise_id" => "23",
      "short_name" => "New Jersey",
      "team_name" => "Devils",
      "abbreviation" => "NJD",
      "link" => "/api/v1/teams/1" }

    actual = @stat_tracker.team_info("1")

    assert_equal expected, actual
  end

  def test_games_played_by_season
    @stat_tracker.games_played_by_season("5",'P')
  end

  def test_games_played_by_team_id
    expected = 6
    actual = @stat_tracker.games_played("6").count

    assert_equal expected, actual
  end

  def test_total_seasons
    expected = 2
    actual = @stat_tracker.total_seasons("6").count

    assert_equal expected, actual
  end

  def test_win_perc_by_season

    expected = {"20122013" => 100, "20162017" => 50}
    actual = @stat_tracker.win_perc_by_season("6")

    assert_equal expected, actual
  end

  def test_highest_and_lowest_win_percentage

    assert_equal "20122013", @stat_tracker.best_season("6")

    assert_equal "20162017", @stat_tracker.worst_season("6")
  end

  def test_average_win_percentage

    expected = 25.0
    actual = @stat_tracker.average_win_percentage("6")

    assert_equal expected, actual
  end

  def test_most_and_fewest_goals_scored

    expected = 6
    actual = @stat_tracker.most_goals_scored("6")
    assert_equal expected, actual

    expected = 1
    actual = @stat_tracker.fewest_goals_scored("6")
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

  def test_outcomes_between_teams
    expected = [3, 0]
    actual = @stat_tracker.team_outcomes("6").first
    assert_equal expected, actual
  end

  def test_biggest_difference_in_scoring
    expected = 5
    actual =
    @stat_tracker.biggest_team_blowout("6")
    assert_equal expected, actual

    expected = 4
    actual =
    @stat_tracker.worst_loss("17")
    assert_equal expected, actual
  end

  def test_head_to_head_for_all_oponents
    skip
    expected = hash
    actual = @stat_tracker.head_to_head
    assert_equal expected, actual
  end

  def test_seasonal_summary

    expected =

    {"20122013"=>
    {:regular_season=>{:win_percentage=>nil, :total_goals_scored=>0, :total_goals_against=>0, :average_goals_scored=>0, :average_goals_against=>0},
     :post_season=>{:win_percentage=>40.0, :total_goals_scored=>27, :total_goals_against=>29, :average_goals_scored=>2, :average_goals_against=>2}},
   "20172018"=>
    {:regular_season=>{:win_percentage=>100.0, :total_goals_scored=>7, :total_goals_against=>1, :average_goals_scored=>3, :average_goals_against=>0},
     :post_season=>{:win_percentage=>nil, :total_goals_scored=>0, :total_goals_against=>0, :average_goals_scored=>0, :average_goals_against=>0}},
   "20162017"=>
    {:regular_season=>{:win_percentage=>50.0, :total_goals_scored=>6, :total_goals_against=>6, :average_goals_scored=>3, :average_goals_against=>3},
     :post_season=>{:win_percentage=>nil, :total_goals_scored=>0, :total_goals_against=>0, :average_goals_scored=>0, :average_goals_against=>0}}}

    actual = @stat_tracker.seasonal_summary("5")

    assert_equal expected, actual
  end

end
