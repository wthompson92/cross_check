require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'
require './lib/league_module'

class LeagueTest < Minitest::Test
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

  def test_number_of_teams_in_league
    assert_equal 31, @stat_tracker.count_of_teams
  end

  def test_converted_to_name
    assert_equal "Islanders", @stat_tracker.convert_id_to_name("2")
  end

  def test_number_of_games_total_played_by_each_team
    expected = ["6", 2]
    assert_equal expected, @stat_tracker.number_of_games_total_played_by_each_team.first
  end

  def test_total_goals_scored_by_each_team
    expected = ["6", 16]
    assert_equal expected, @stat_tracker.total_goals_scored_by_each_team.first
  end

  def test_league_offense_data
    assert_equal "Senators", @stat_tracker.best_offense
    assert_equal "Devils", @stat_tracker.worst_offense
  end

  def test_total_scored_on_by_team
    expected = ["6", 7]
    assert_equal expected, @stat_tracker.total_scored_on_by_team.first
  end

  def test_best_defense_data
    assert_equal "Sabres", @stat_tracker.best_defense
    assert_equal "Maple Leafs", @stat_tracker.worst_defense
  end

  def test_average_home_goals
    expected = ["5", 2.57]
    assert_equal expected, @stat_tracker.average_goals_scored_by_home_team.first
  end

  def test_average_away_goals
    expected = ["6", 4.0]
    assert_equal expected, @stat_tracker.average_goals_scored_by_away_team.first
  end

  def test_highest_scoring_teams
    assert_equal "Oilers", @stat_tracker.highest_scoring_visitor
    assert_equal "Golden Knights", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_teams
    assert_equal "Panthers", @stat_tracker.lowest_scoring_visitor
    assert_equal "Bruins", @stat_tracker.lowest_scoring_home_team
  end

  def test_league_winningest_team
    assert_equal "Devils", @stat_tracker.winningest_team
  end

  def test_fan_methods
    assert_equal "Maple Leafs", @stat_tracker.best_fans
    expected = []
    assert_equal expected, @stat_tracker.worst_fans
  end

end
