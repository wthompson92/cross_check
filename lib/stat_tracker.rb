require 'csv'

class StatTracker
attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = []
    @teams = []
    @game_teams = []
    @locations = locations
  end

  def self.build_table(locations)
    CSV.table(locations, headers: true)
  end

  def self.from_csv(locations)
    @games << build_table(locations[:games])
    @teams << build_table(locations[:teams])
    @game_teams << build_table(locations[:game_teams])
  end
end
