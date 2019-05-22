module League
  def get_teams
    team_ids = []
    game_team.each do |instance|
      team_ids << instance.away_team_id
      team_ids << instance.home_team_id
    end
    team_ids.uniq
  end

  def count_of_teams
    get_teams.count
  end

  def best_offense
  end

  def worst_offense
  end
end
