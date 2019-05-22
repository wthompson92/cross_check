require_relative 'test_helper'
require 'csv'
require 'pry'
require './runner'
require 'stat_tracker'
require './lib/game'

class GameTest < Minitest::Test

  def test_highest_total_score
    expected = int
    assert_equal expected, game.highest_total_score
  end

  def test_lowest_total_score
    expected = int
    assert_equal expected, game.lowest_total_score
  end

  def test_biggest_blowout
    expected = int
    assert_equal expected, biggest_blowout
  end

  def test_percentage_home_wins
    expected = float
    assert_equal expected, game.percentage_home_wins
  end

  def test_percentage_visitor_wins
    expected = float
    assert_equal expected, game.percentage_visitor_wins
  end

  def test_count_of_games_by_season
    expected = hash
    assert_equal expected, game.count_of_games_by_season
  end

  def test_average_goals_per_game
    expected = float
    assert_equal expected, game.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = hash
    assert_equal expected, game.average_goals_by_season
  end
end
