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
   get_teams.each do |id|  games.each do |game|
     if game.home_team_id == (id)
      home_goals[id] = game.home_goals
     end
    end
   end
   home_goals
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
    total_scored_on_by_team.min_by { |k,v| v }
  end

  def worst_defense
    total_scored_on_by_team.max_by { |k,v| v }
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
