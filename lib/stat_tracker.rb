require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'game_module'
<<<<<<< HEAD
require_relative 'league_module'

class StatTracker
    include GameModule
    include LeagueModule
=======
require_relative 'team_module_two'

class StatTracker
    include GameModule
    include TeamModule
>>>>>>> af729e6f76c3e7f9e0963542019827ed37a261a3

    attr_reader :games, :teams, :game_teams

    def initialize(games, teams, game_teams)
      @games = games
      @teams = teams
      @game_teams = game_teams
    end

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
end
