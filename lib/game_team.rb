require 'pry'
require 'csv'


class GameTeam
  attr_reader :game_id,
              :team_id,
              :hoa,
              :won,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :hits,
              :pim,
              :power_play_opportunities,
              :power_play_goals,
              :face_off_win_percentage,
              :giveaways,
              :takeaways
  def initialize(row)
    @game_id = row[:game_id]
    @team_id = row[:team_id]
    @hoa = row[:hoa]
    @won = row[:won]
    @settled_in = row[:settled_in]
    @head_coach = row[:head_coach]
    @goals = row[:goals].to_i
    @shots = row[:shots].to_i
    @hits = row[:hits].to_i
    @pim = row[:pim].to_i
    @power_play_opportunities = row[:powerPlayOpportunities].to_i
    @power_play_goals =row[:powerPlayGoals].to_i
    @face_off_win_percentage = row[:faceOffWinPercentage].to_i
    @giveaways = row[:giveaways].to_i
    @takeaways = row[:takeaways].to_i
  end
end