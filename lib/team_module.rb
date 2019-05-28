require 'pry'

module TeamModule

  def team_info(id)
    team = teams.find{|x| x.team_id == id}
    team_hash = { "team_id" => team.team_id,
    "franchise_id" => team.franchise_id,
    "short_name" => team.short_name,
    "team_name" => team.team_name,
    "abbreviation" => team.abbreviation,
    "link" => team.link}
  end

  def games_played(team_id)
    games.find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end
  end

  def total_seasons(team_id)
    seasons = []
    games_played(team_id).each{ |game| seasons << game.season }
    seasons.uniq
  end

  def win_perc_by_season(seasons, games, team_id)
    regular = win_perc_by_season_(seasons, games, team_id, "R")
    post = win_perc_by_season_(seasons, games, team_id, "P")
    regular.merge(post){|key, oldval, newval| ((newval + oldval) / 2).to_i}
  end

  def win_perc_by_season_(seasons, games, team_id, postseason)
    win_percent_by_season = {}
    seasons.find_all do |season|
      wins = 0
      games_by_season = 0
      games.find_all do |game|
        if game.season == season && game.type.include?(postseason)
          games_by_season += 1
          if game.away_team_id == team_id && game.outcome.include?("away")
            wins += 1
          end
          if game.home_team_id == team_id && game.outcome.include?("home")
            wins += 1
          end
        end
      end
      winning_percentage = wins.to_f / games_by_season * 100
      if !winning_percentage.to_f.nan?
        win_percent_by_season.store(season, winning_percentage)
      end
    end
    win_percent_by_season
  end

  def best_season(team_id)
    seasons = total_seasons(team_id)
    games = games_played(team_id)
    winning_percentages = win_perc_by_season(seasons, games, team_id)
    winning_percentages.max_by { |season, win_percent| win_percent }.first
  end

  def worst_season(team_id)
    seasons = total_seasons(team_id)
    games = games_played(team_id)
    winning_percentages = win_perc_by_season(seasons, games, team_id)
    winning_percentages.min_by { |season, win_percent| win_percent }.first
  end

  def average_win_percentage(team_id)
    seasons = total_seasons(team_id)
    games = games_played(team_id)
    winning_percentages = win_perc_by_season(seasons, games, team_id)
    sum = winning_percentages.sum { |season, win_percent| win_percent }
    (sum.to_f / games_played(team_id).count).round(2)
  end

  def all_goals(team_id)
    all_goals = []
    games_played(team_id).find_all do |game|
      if game.away_team_id == team_id
        all_goals << game.away_goals
      elsif game.home_team_id == team_id
        all_goals << game.home_goals
      end
    end
    all_goals
  end

  def most_goals_scored(team_id)
    all_goals(team_id).max
  end

  def fewest_goals_scored(team_id)
    all_goals(team_id).min
  end

  def win_percentage_against_all_teams(team_id)
    games_played(team_id).group_by do |game|
      game.outcome
    end
  end

  def favorite_opponent(team_id)
  end

  def rival
  end

  def team_outcomes(team_id)
    outcomes = []
    games_played(team_id).each do |game|
      if game.home_team_id == team_id
        outcomes << [game.home_goals, game.away_goals]
      elsif game.away_team_id == team_id
        outcomes << [game.away_goals, game.home_goals]
      end
    end
    return outcomes
  end

  def biggest_team_blowout(team_id)
    greatest_diff = team_outcomes(team_id).map do |outcome|
      outcome[0] - outcome[1]
    end.max
  end

  def worst_loss(team_id)
    greatest_diff = team_outcomes(team_id).map do |outcome|
      outcome[1] - outcome[0]
    end.max
  end

  def head_to_head
    # Record (as a hash - win/loss) against all opponents with the opponents’
    # names as keys and the win percentage against that opponent as a value
  end

  def total_goals_scored(team_id, postseason)
    total_goals_by_season = {}
    away_goals = []
    home_goals = []
    total_seasons(team_id).each do |season|
      games.each do |game|
        if game.type.include?(postseason) && game.away_team_id == team_id
          away_goals << game.away_goals
        elsif game.type.include?(postseason) && game.home_team_id == team_id
          home_goals << game.home_goals
        end
      total_goals_by_season[season] = away_goals.sum + home_goals.sum
      end
    end
    total_goals_by_season
  end

  def total_goals_scored_by_reg(team_id)
    total_goals_scored(team_id, "R")
  end

  def total_goals_scored_by_post(team_id)
    total_goals_scored(team_id, "P")
  end

  def total_goals_scored_against_reg
  end

  def total_goals_scored_against_post
  end

  def average_goals_scored_reg
  end

  def average_goals_scored_post
  end

  def average_goals_against_reg
  end

  def average_goals_against_post
  end

  def seasonal_summary(team_id)
    seasons = total_seasons(team_id)
    games = games_played(team_id)
    summary = {}
    regular = win_perc_by_season_(seasons, games, team_id, "R")
    post = win_perc_by_season_(seasons, games, team_id, "P")
    total_seasons(team_id).each do |season|
      summary[season] = {regular_season: {win_percentage: regular[season]}}
    end
    return summary
  end
  # For each season that the team has played, a hash that has two keys (:regular_season and :postseason), that each point to a hash with the following keys: :win_percentage, :total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against.

end
