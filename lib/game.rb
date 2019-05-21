require 'csv'
require 'pry'

class Game

  def self.avg_goals_per_game
    rows = CSV.table("./data/game.csv")


    game_count = 0
    home_goals = 0
    away_goals = 0
    rows.each do |row|
      binding.pry

      row[:season] = row
      game_count += 1
      away_goals += row['away_goals'].to_i
      home_goals += row['home_goals'].to_i
    end

    away_avg = away_goals / game_count.to_f
    home_avg = home_goals / game_count.to_f

    "avg game is Home:#{home_avg} vs Away:#{away_avg}"
  end
end


puts Game.avg_goals_per_game
