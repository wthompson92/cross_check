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

  def test_number_of_games_total_played_by_each_team
    expected = {"6"=>2, "5"=>7, "17"=>8, "16"=>10, "9"=>3, "8"=>3, "30"=>2, "26"=>5, "19"=>3, "24"=>5, "2"=>7, "3"=>2, "15"=>2, "25"=>2, "21"=>4, "23"=>2, "29"=>3, "14"=>1, "13"=>5, "52"=>3, "20"=>2, "22"=>3, "1"=>1, "54"=>1, "53"=>3, "12"=>5, "10"=>1}

    actual = @stat_tracker.number_of_games_total_played_by_each_team
    assert_equal expected, actual
  end
  #
  def test_total_goals_scored_by_each_team
    expected = {"6"=>4, "5"=>3, "17"=>3, "16"=>7, "9"=>6, "8"=>2, "30"=>4, "26"=>2, "19"=>4, "24"=>4, "2"=>4, "3"=>3, "15"=>5, "25"=>3, "21"=>2, "23"=>2, "29"=>2, "14"=>4, "13"=>1, "52"=>3, "20"=>4, "22"=>7, "1"=>5, "54"=>4, "53"=>2, "12"=>3, "10"=>4, "4"=>4, "18"=>5, "28"=>2, "7"=>2}

    actual = @stat_tracker.total_goals_scored_by_each_team
    assert_equal expected, actual
  end
  #
  #
  def test_league_offence_data
    expected = "Senators"
    actual = @stat_tracker.best_offense
    assert_equal expected, actual

    expected = "Devils"
    actual = @stat_tracker.worst_offense
    assert_equal expected, actual
  end

  # def test_league_defense_data
  #   expected = string
  #   actual = @league.best_defense
  #   assert_equal expected, actual
  #
  #   expected = string
  #   actual = @league.worst_defense
  #   assert_equal expected, actual
  # end
  #
  # # def test_highest_scoring_methods
  # #   skip
  #   expected = string
  #   actual = @league.highest_scoring_visitor
  #   assert_equal expected, actual
  #
  #   expected = string
  #   actual = @league.highest_scoring_home_team
  #   assert_equal expected, actual
  # end
  #
  #
  # def test_lowest_scoring_methods
  #   skip
  #   expected = string
  #   actual = @league.lowest_scoring_visitor
  #   assert_equal expected, actual
  #
  #   expected = string
  #   actual = @league.lowest_home_team
  #   assert_equal expected, actual
  # end
  #
  # def test_league_winningest_team
  #   skip
  #   actual = string
  #   expected = @league.winningest_team
  #   assert_equal expected, actual
  # end
  #
  # def test_fan_methods
  #   skip
  #   expected = string
  #   actual = @league.best_fans
  #   assert_equal expected, actual
  #
  #   expected = array
  #   actual = @league.worst_fans
  #   assert_equal expected, actual
  # end
end
