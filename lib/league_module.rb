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
  end

  def worst_offense
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
