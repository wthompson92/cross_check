require 'pry'

module LeagueModule

  def get_teams
    team_ids = []
    games.each do |game|
      team_ids << game.away_team_id
      team_ids << game.home_team_id
    end
    team_ids.uniq
  end

  def count_of_teams
    get_teams.count
  end

  def convert_id_to_name(team_id)
    teams.find do |team|
      if team.team_id == team_id
       return team.team_name
      end
    end
  end

  def number_of_games_total_played_by_each_team
    hash = Hash.new(0)
    get_teams.each do |id|
      games.each do |game|
        if (game.home_team_id || game.away_team_id) == (id)
          hash[id] += 1
        end
      end
    end
  hash
  end

  def total_scored_on_by_team
    scored_on = Hash.new(0)
    get_teams.each do |team|
      games.each do |game|
        if game.home_team_id == team
          scored_on[team] += game.away_goals
        elsif game.away_team_id == team
          scored_on[team] += game.home_goals
        end
      end
    end
    scored_on
  end

  def average_goals_allowed
    number = number_of_games_total_played_by_each_team
    total_scored_on_by_team.merge(number) do |k, scored_on, game|
      scored_on / game.to_f
    end
  end

  def goals_by_team
    goals = Hash.new(0)
    get_teams.each do |team|
      games.each do |game|
        if game.home_team_id == team
          goals[team] += game.home_goals
        elsif game.away_team_id == team
          goals[team] += game.away_goals
        end
      end
    end
    goals
  end

  def average_goals_scored_by_teams
    number = number_of_games_total_played_by_each_team
    goals_by_team.merge(number) do |k, goals, game|
      goals / game.to_f
    end
  end

  def best_offense
    best = average_goals_scored_by_teams.max_by { |k,v| v }
    convert_id_to_name(best.first)
  end

  def worst_offense
    worst = average_goals_scored_by_teams.min_by { |k,v| v }
    convert_id_to_name(worst.first)
  end


  def best_defense
    best = average_goals_allowed.min_by { |k,v| v }
    convert_id_to_name(best.first)
  end

  def worst_defense
    worst = average_goals_allowed.max_by { |k,v| v }
    convert_id_to_name(worst.first)
  end

  def average_goals_scored_by_home_team
    home = Hash.new
    hash = games.group_by{ |game| game.home_team_id }
      hash.each do |team_id, games|
        goals = games.map{ |game| game.home_goals }
        goals = (goals.sum / goals.count.to_f).round(2)
        home[team_id] = goals
      end
    home
  end

  def average_goals_scored_by_away_team
    away = Hash.new
    hash = games.group_by{ |game| game.away_team_id }
      hash.each do |team_id, games|
        goals = games.map{ |game| game.away_goals }
        goals = (goals.sum / goals.count.to_f).round(2)
        away[team_id] = goals
      end
    away
  end

  def highest_scoring_visitor
      team_id = average_goals_scored_by_away_team.max_by{ |team_id, goals| goals }.first
      convert_id_to_name(team_id)
  end

  def lowest_scoring_visitor
      team_id = average_goals_scored_by_away_team.min_by{ |team_id, goals| goals }.first
      convert_id_to_name(team_id)
  end

  def highest_scoring_home_team
    home = average_goals_scored_by_home_team
    team_id = home.max_by{ |team_id, goals| goals }.first
    convert_id_to_name(team_id)
  end

  def lowest_scoring_home_team
    home = average_goals_scored_by_home_team
    team_id = home.min_by{ |team_id, goals| goals }.first
    convert_id_to_name(team_id)
  end
end
