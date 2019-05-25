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
      if team.team_id == team_id.to_i
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
        else game.away_team_id == team
          scored_on[team] += game.home_goals
        end
      end
    end
    scored_on
  end

  def home_goals_by_team
    home_goals = Hash.new(0)
    get_teams.each do |id|
      games.each do |game|
        if game.home_team_id == (id)
          home_goals[id] = game.home_goals
        end
      end
    end
    home_goals
  end

  def away_goals_by_team
   away_goals = Hash.new(0)
   get_teams.each do |id| games.each do |game|
    if game.away_team_id == (id)
       away_goals[id] = game.away_goals
        end
      end
    end
    away_goals
  end

  def total_goals_scored_by_each_team
    home_goals_by_team.merge(away_goals_by_team)
  end

  def best_offense
    hash = Hash.new
    total_goals_scored_by_each_team.map do |key, value|
      number_of_games_total_played_by_each_team.map do |k, v|
      hash[key] = value / v.to_f
     end
   end
     best = hash.max
     convert_id_to_name(best.first)
  end

  def worst_offense
    hash = Hash.new
    total_goals_scored_by_each_team.map do |key, value|
      number_of_games_total_played_by_each_team.map do |k, v|
      hash[key] = value / v.to_f
     end
     end
     worst = hash.min
     convert_id_to_name(worst.first)
  end

  def best_defense
    total_scored_on_by_team.min_by { |k,v| v }
  end

  def worst_defense
    total_scored_on_by_team.max_by { |k,v| v }
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
    away = average_goals_scored_by_away_team
      team_id = away.max_by{ |team_id, goals| goals }.first.to_i
        teams.find { |team| team_id == team.team_id }.team_name
  end

  def lowest_scoring_visitor
    away = average_goals_scored_by_away_team
      team_id = away.min_by{ |team_id, goals| goals }.first.to_i
        teams.find { |team| team_id == team.team_id }.team_name
  end

  def highest_scoring_home_team
    home = average_goals_scored_by_home_team
      team_id = home.max_by{ |team_id, goals| goals }.first.to_i
        teams.find { |team| team_id == team.team_id }.team_name
  end

  def lowest_scoring_home_team
    home = average_goals_scored_by_home_team
      team_id = home.min_by{ |team_id, goals| goals }.first.to_i
        teams.find { |team| team_id == team.team_id }.team_name

  end

  # def winningest_team
  # end
  #
  # def best_fans
  #
  # end

  def  worst_fans
  end
end
