require './lib/stat_tracker'
require 'pry'

game_path = './data/game_dummy.csv'
team_path = './data/team_info_dummy.csv'
game_teams_path = './data/game_teams_stats_dummy.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}


stat_tracker = StatTracker.from_csv(locations)
binding.pry
