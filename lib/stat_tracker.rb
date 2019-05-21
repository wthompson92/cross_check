require 'csv'

class StatTracker
attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.build_table(location)
    CSV.table(location, headers: true)
  end

  def self.from_csv(locations)
    games = build_table(locations[:games])
    teams = build_table(locations[:teams])
    game_teams = build_table(locations[:game_teams])

    self.new(games, teams, game_teams)
  end
end

class StatTracker

  def initialize(locations)
    @game_path = game_path
    @team_path =
    @game_teams_path =
    @location
  end

  def self.from_csv(locations)
    CSV.table(locations)

    # locations.each do |location|
    end
  end



  # @games << Game.new(row)
