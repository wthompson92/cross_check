require 'pry'


module GameModule

  def get_total_score
    games.map do |game|
      game.home_goals + game.away_goals
    end
  end

  def highest_total_score
    get_total_score.max
  end

  def lowest_total_score
    get_total_score.min
  end

  def biggest_blowout
    games.map do |game|
      (game.home_goals - game.away_goals).abs
    end.max
  end

  def win_counter(hoa)
    games.find_all do |game|
      game.outcome.include? hoa
    end.count
  end

  def percentage_home_wins
    (win_counter("home") / games.count.to_f * 100).round(2)
  end

  def percentage_visitor_wins
    (win_counter("away") / games.count.to_f * 100).round(2)
  end

  def count_of_games_by_season
    games_by_seasons = games.group_by{ |game| game.season.to_s }
    games_by_seasons.transform_values{ |values| values.count }
  end

  def average_goals_per_game
    (get_total_score.sum / games.count.to_f).round(2)
  end

  def average_goals_by_season
    games_by_seasons = games.group_by{ |game| game.season.to_s }
    games_by_seasons.transform_values do |row|
      total_goals = row.sum{ |column| column.home_goals + column.away_goals }
      (total_goals / row.count.to_f).round(2)
    end
  end

end
