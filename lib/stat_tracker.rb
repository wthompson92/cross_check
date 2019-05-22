require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class StatTracker
  
attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = []
    @teams = []
    @game_teams = []
    @locations = locations
  end

<<<<<<< HEAD
  def self.build_table(locations)
    CSV.table(locations, headers: true)
  end

  def self.from_csv(locations)
    @games << build_table(locations[:games])
    @teams << build_table(locations[:teams])
    @game_teams << build_table(locations[:game_teams])
  end
=======
  def self.from_csv(locations)
    games = []
    teams = []
    game_teams = []

    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      games << Game.new(row)
    end
    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
      teams << Team.new(row)
    end
    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
      game_teams << GameTeam.new(row)
    end
    self.new(games, teams, game_teams)
  end


>>>>>>> 6c5100dcefa23998f4b979e24d22787bcd950e8e
end
