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
    if teams.any? do |team|
      team.include?(team_id)
      return team.short_name
    end
  end
end 


  def number_of_games_total_played_by_each_team
    hash = Hash.new(0)
    get_teams.each do |id|
    games.each do |game|
    if (game.home_team_id || game.away_team_id) == (id)
      then
      hash[id] += 1
    end
  end
  end
  hash
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

  def highest_scoring_visitor
  end

  def lowest_scoring_visitor
  end

  def highest_scoring_home_team
  end

  def lowest_scoring_home_team
  end

  def winningest_team
  end

  def best_fans
  end

  def  worst_fans
  end
end
