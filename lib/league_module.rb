module LeagueModule

  def get_teams
    team_ids = []
      game_teams.each do |instance|
        team_ids << instance.team_id
      end
    team_ids.uniq
  end

  def count_of_teams
    get_teams.count
  end

  def number_of_games_total_played_by_each_team
    games_grouped = game_teams.group_by{|game| game.team_id }
    games_grouped.transform_values{|values| values.count }
  end

  def total_goals_scored_by_each_team
  goals_grouped = game_teams.group_by{|game| game.team_id }
  goals_grouped.transform_values{|values| values.sum {|value|
    value.goals}}
  end


  def total_goals_scored_on_each_team
  end

  def total_goals_scored_by_each_team_as_home_team
  end

  def total_goals_scored_by_each_team_as_away_team
  end

  def biggest_home_v_away_winrate_by_team
  end


  def best_offense
    hash = Hash.new
    total_goals_scored_by_each_team.map do |key, value|
      number_of_games_total_played_by_each_team.map do |k, v|
      hash[key] = value / v.to_f
     end
     end
     hash.max_by{|k,v| k = v}
  end

  def worst_offense
    hash = Hash.new
    total_goals_scored_by_each_team.map do |key, value|
      number_of_games_total_played_by_each_team.map do |k, v|
      hash[key] = value / v.to_f
     end
     end
     hash.min_by{|k,v| k = v}
  end

  def best_defense
  end

  def worst_defense
  end

  def home_goals_by_team
   home_goals = Hash.new
    get_teams.each do |id|
      games.each do |game|
        if game.home_team_id == (id)
          home_goals[id] += game.home_goals
        end
      end
    end
   home_goals
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

  def winningest_team
  end

  def best_fans
  end

  def  worst_fans
  end
end
