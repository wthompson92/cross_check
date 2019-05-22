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

  def total_goals_scored_by_team
    goals_by_team = get_teams.map do |teams|
      team.sum do |instance|
      instance.goals
    end
    goals_by_team.sort!
    end


  def best_offense
  end

  def worst_offense
  end
end
