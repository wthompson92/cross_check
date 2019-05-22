require './runner'
require 'pry'

module TeamModule

  def team_info(team_id)
    stat_tracker.teams
  end

  def best_season
    binding.pry
    # get array of team_id
    # for each team_id or group by team_id, ( see stack overflow)
    # iterate over :won and return all true for team.count
    # store the best score in maybe a hash {:id => team_score}
    # return highest win percentage
  end

  def worst_season
    # return lowest win percentage
  end

  def average_win_percentage
    # return average win percentage
  end

  def most_goals_scored
  end

  def fewest_goals_scored
  end

  def favorite_opponent
    # opponent with lowest win percentage (string)
  end

  def rival
    # opponent with highest win percentage (string)
  end

  def biggest_team_blowout
    # biggest difference between goals for a WIN between team and opponent
  end

  def worst_loss
    # biggest difference between goals for a LOSS between team and opponent
  end

  def head_to_head
    # Record (as a hash - win/loss) against all opponents with the opponents’
    # names as keys and the win percentage against that opponent as a value
  end

  def seasonal_summary
    # for each season that the team has played, a hash that has two keys (:regular_season and :postseason), that each point to a hash with the following keys: :win_percentage, :total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against.
  end
end
