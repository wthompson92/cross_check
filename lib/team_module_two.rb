require 'pry'

module TeamModule

  def seasonal_summary(team_id)
    group_team = games.select do |game|
      team_id == game.home_team_id || team_id == game.away_team_id
    end

    # regular_season = group_team.group_by do |team|
    #   team.type
    # end


    # For each season that the team has played,
    # a hash that has two keys (:regular_season and :postseason),
    # that each point to a hash with the following keys:
    # :win_percentage
    # :total_goals_scored
    # :total_goals_against
    # :average_goals_scored
    # :average_goals_against
  end

  def team_info(id)
    team = teams.find{|x| x.team_id == id}

    team_hash = {
    "team_id" => team.team_id,
    "franchise_id" => team.franchise_id,
    "short_name" => team.short_name,
    "team_name" => team.team_name,
    "abbreviation" => team.abbreviation,
    "link" => team.link}
  end
end
