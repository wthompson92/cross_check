require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'pry'

class LeagueTest < Minitest::Test
    def setup
      locations = {
        games: './data/game_dummy.csv',
        teams: './data/team_info_dummy.csv',
        game_teams: './data/game_teams_stats_dummy.csv'
      }
      @stat_tracker = StatTracker.from_csv(locations)
    end

  def test_it_exists
    expected = StatTracker
    actual = @stat_tracker
    assert_instance_of expected, actual
  end

  def test_number_of_teams_in_league
    expected = 2
    actual = @stat_tracker.count_of_teams
    assert_equal expected, actual
  end

  def test_number_of_games_total_played_by_each_team
    expected = {"3"=>5, "6"=>4}
    actual = @stat_tracker.number_of_games_total_played_by_each_team
    assert_equal expected, actual
  end

  def test_total_goals_scored_by_each_team
    expected = {"3"=>10, "6"=>13}
    actual = @stat_tracker.total_goals_scored_by_each_team
    assert_equal expected, actual
  end


  def test_league_offence_data
    expected = []
    actual = @stat_tracker.best_offense
    assert_equal expected, actual

    expected = string
    actual = @league.worst_offense
    assert_equal expected, actual
  end

  def test_league_defense_data
    skip
    expected = string
    actual = @league.best_defense
    assert_equal expected, actual

    expected = string
    actual = @league.worst_defense
    assert_equal expected, actual
  end

  def test_highest_scoring_methods
    skip
    expected = string
    actual = @league.highest_scoring_visitor
    assert_equal expected, actual

    expected = string
    actual = @league.highest_scoring_home_team
    assert_equal expected, actual
  end


  def test_lowest_scoring_methods
    skip
    expected = string
    actual = @league.lowest_scoring_visitor
    assert_equal expected, actual

    expected = string
    actual = @league.lowest_home_team
    assert_equal expected, actual
  end

  def test_league_winningest_team
    skip
    actual = string
    expected = @league.winningest_team
    assert_equal expected, actual
  end

  def test_fan_methods
    skip
    expected = string
    actual = @league.best_fans
    assert_equal expected, actual

    expected = array
    actual = @league.worst_fans
    assert_equal expected, actual
  end
end
