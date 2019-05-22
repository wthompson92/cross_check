require 'pry'


module GameModule

  def highest_total_score
    goals = games.map do |game|
      game.home_goals + game.away_goals
    end
    goals.max
  end

  def lowest_total_score
    goals = games.map do |game|
      game.home_goals + game.away_goals
    end
    goals.min
  end

  def biggest_blowout
    goals = games.map do |game|
      (game.home_goals - game.away_goals).abs
    end
    goals.max
  end

  def percentage_home_wins
    count_of_game = 0
    home_wins = 0.0

    games.map do |game|
      count_of_game += 1
      home_wins += 1 if game.outcome.include?("home")
    end
    (home_wins / count_of_game * 100).round(2)
  end

  def percentage_visitor_wins
    count_of_game = 0
    home_wins = 0.0

    games.map do |game|
      count_of_game += 1
      home_wins += 1 if game.outcome.include?("away")
    end
    (home_wins / count_of_game * 100).round(2)
  end

  def count_of_games_by_season
    games_by_seasons = games.group_by{|game| game.season}
    games_by_seasons.transform_values{|values| values.count}
  end

  def average_goals_per_game
    count_of_game = 0
    goals = games.map do |game|
      count_of_game += 1
      game.home_goals + game.away_goals
    end
    (goals.sum / count_of_game.to_f).round(2)
  end

  def average_goals_by_season
    games_by_seasons = games.group_by{|game| game.season}
    games_by_seasons.transform_values do |value|
      total_goals = value.sum{|totals| totals.home_goals + totals.away_goals}
      (total_goals / value.count.to_f).round(2)
    end
  end
end
