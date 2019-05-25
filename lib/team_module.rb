require 'pry'

module TeamModule

  def team_by_id(team_id)
    teams.find do |team|
      team.team_id == team_id
    end
  end

  def team_info(team_id)
    team_obj = team_by_id(team_id)
    my_team = { "team_id" => team_obj.team_id,
      "franchise_id" => team_obj.franchise_id,
    "short_name" => team_obj.short_name,
    "team_name" => team_obj.team_name,
    "abbreviation" => team_obj.abbreviation,
    "link" => team_obj.link}
  end

  def games_played(team_id)
    games.find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end
  end

  def total_seasons(team_id)
    seasons = []
    games_played(team_id).each do |game|
      seasons << game.season
    end
    seasons.uniq
  end

  def win_perc_by_season(seasons, games, team_id)
    win_percent_by_season = {}
    seasons.find_all do |season|
      wins = 0
      games_by_season = 0
      games.find_all do |game|
        if game.season == season
          games_by_season += 1
          if game.away_team_id == team_id && game.outcome.split.first == "away"
            wins += 1
          end
          if game.home_team_id == team_id && game.outcome.split.first == "home"
            wins += 1
          end
        end
      end
      winning_percentage = (wins.to_f / games_by_season * 100).to_i
      win_percent_by_season.store(season, winning_percentage)
    end
    win_percent_by_season
  end

  def best_season(team_id)
    seasons = total_seasons(team_id)
    games = games_played(team_id)
    winning_percentages = win_perc_by_season(seasons, games, team_id)
    winning_percentages.max_by { |k,v| v }.first
  end

  def worst_season(team_id)
    seasons = total_seasons(team_id)
    games = games_played(team_id)
    winning_percentages = i_dont_know(seasons, games, team_id)
    winning_percentages.min_by { |k,v| v }.first
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