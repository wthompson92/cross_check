require './lib/league'
require 'pry'
class League
  def initialize(data_hash)
    @game_id = data_hash[:game_id]
    @season = data_hash[:season]
    @type = data_hash[:type]
    @date_time = data_hash[:date_time]
    @away_team_id = data_hash[:away_team_id]
    @home_team_id = data_hash[:home_team_id]
    @away_goals = data_hash[:away_goals]
    @home_goals = data_hash[:home_goals]
    @outcome = data_hash[:outcome]
  end
  def count_of_teams
    @teams.count
  end

  def best_offense
  end

  def worst_offense

end
end
