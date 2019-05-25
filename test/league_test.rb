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

  def test_number_of_teams_in_league
    expected = 31
    actual = @stat_tracker.count_of_teams
    assert_equal expected, actual
  end

  def test_converted_to_name
    expected = "Islanders"
    actual = @stat_tracker.convert_id_to_name(2)
    assert_equal expected, actual
  end

  def test_number_of_games_total_played_by_each_team

    expected = ["6", 2]
    actual = @stat_tracker.number_of_games_total_played_by_each_team.first
    assert_equal expected, actual
  end


  def test_total_goals_scored_by_each_team
    expected = ["6", 16]
    actual = @stat_tracker.total_goals_scored_by_each_team.first
   assert_equal expected, actual
  end

  def test_league_offense_data
    expected = "Senators"
    actual = @stat_tracker.best_offense
    assert_equal expected, actual

    expected = "Devils"
    actual = @stat_tracker.worst_offense
    assert_equal expected, actual
  end

  def test_average_home_goals
    expected = ["5", 2.57]
    actual = @stat_tracker.average_goals_scored_by_home_team.first
    assert_equal expected, actual
  end

  def test_average_away_goals
    expected = ["6", 4.0]
    actual = @stat_tracker.average_goals_scored_by_away_team.first
    assert_equal expected, actual
  end

  def test_highest_scoring_teams

    expected = "Oilers"
    actual =  @stat_tracker.highest_scoring_visitor
    assert_equal expected, actual

    expected = "Golden Knights"
    actual = @stat_tracker.highest_scoring_home_team
    assert_equal expected, actual
  end

  def test_lowest_scoring_teams
    
    expected = "Panthers"
    actual =
    @stat_tracker.lowest_scoring_visitor
    assert_equal expected, actual

    expected = "Bruins"
    actual = @stat_tracker.lowest_scoring_home_team
    assert_equal expected, actual
  end
end
