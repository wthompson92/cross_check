require 'pry'

module TeamModule

  def team_info(id)
    team = teams.find{|x| x.team_id == id}
    { "team_id" => team.team_id,
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

  def games_played_by_season(team_id, postseason)
    games_played(team_id).find_all do |game|
      game.type == postseason
    end.group_by do |game|
      game.season
    end.transform_values do |games_in_season|
      games_in_season.length
    end
  end

  def win_perc_by_season(seasons, games, team_id)
    regular = win_perc_by_season_(seasons, games, team_id, "R")
    post = win_perc_by_season_(seasons, games, team_id, "P")
    regular.merge(post){|key, oldval, newval| ((newval + oldval) / 2).to_i}
  end

  def we_won_this_game(team_id,game)
    away_won = game.away_team_id == team_id && game.outcome.include?("away")
    home_won = game.home_team_id == team_id && game.outcome.include?("home")
    away_won || home_won
  end

  def win_perc_by_season_(team_id, postseason)
    win_percent_by_season = {}
    total_seasons(team_id).find_all do |season|
      wins = 0
      games_by_season = 0
      games_played(team_id).find_all do |game|
        if game.season == season && game.type.include?(postseason)
          games_by_season += 1
          wins += 1 if we_won_this_game(team_id,game)
        end
      end
      winning_percentage = wins.to_f / games_by_season
      if !winning_percentage.to_f.nan?
        win_percent_by_season.store(season, winning_percentage)
      end
    end
    win_percent_by_season
  end

  def best_season(team_id)
    winning_percentages = win_perc_by_season(team_id)
    winning_percentages.max_by { |season, win_percent| win_percent }.first
  end

  def worst_season(team_id)
    winning_percentages = win_perc_by_season(team_id)
    winning_percentages.min_by { |season, win_percent| win_percent }.first
  end

  def average_win_percentage(team_id)
    team_games = games.find_all do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
    team_wins = games.count do |game|
      we_won_this_game(team_id, game)
    end
    (team_wins / team_games.length.to_f).round(2)
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
    team_outcomes(team_id).map do |outcome|
      outcome[0] - outcome[1]
    end.max
  end

  def worst_loss(team_id)
    team_outcomes(team_id).map do |outcome|
      outcome[1] - outcome[0]
    end.max
  end

  def total_goals_scored(team_id, postseason)
    total_goals_by_season = {}
    total_seasons(team_id).each do |season|
      goals = []
      games_played(team_id).find_all do |game|
        if game.season == season
          if game.type.include?(postseason) && game.away_team_id == team_id
            goals << game.away_goals
          elsif game.type.include?(postseason) && game.home_team_id == team_id
            goals << game.home_goals
          end
        end
      end
      total_goals_by_season[season] = goals.sum
    end
    total_goals_by_season
  end

  def total_goals_scored_against(team_id, postseason)
    total_goals_against_by_season = {}
    total_seasons(team_id).each do |season|
      goals = []
      games_played(team_id).find_all do |game|
        if game.season == season
          if game.type.include?(postseason) && game.away_team_id == team_id
            goals << game.home_goals
          elsif game.type.include?(postseason) && game.home_team_id == team_id
            goals << game.away_goals
          end
        end
      end
      total_goals_against_by_season[season] = goals.sum
    end
    total_goals_against_by_season
  end

  def average_goals_scored(team_id, postseason)
    average = {}
    total_goals_scored(team_id, postseason).each do |season, goals|
      my_games = games_played_by_season(team_id, postseason)[season].to_f
      if my_games == 0
        average[season] = 0.0
      else
        average[season] = (goals / my_games).round(2)
      end
    end
    average
  end

  def average_goals_against(team_id, postseason)
    average = {}
    total_goals_scored_against(team_id, postseason).each do |season, goals|
      my_games = games_played_by_season(team_id, postseason)[season].to_f
      if my_games == 0
        average[season] = 0.0
      else
        average[season] = (goals / my_games).round(2)
      end
    end
    average
  end

  def team_wins(team_id)
    wins = []
    games_shared(team_id).each do |game|
      if game.away_team_id == team_id && game.outcome.include?("away") ||
         game.home_team_id == team_id && game.outcome.include?("home")
        wins.push(game)
      end
    end
    wins.count.to_f
  end

  def other_team(team_id)
    ot = []
    rivals(team_id).each do |rival|
      ot << teams.find_all { |team| team.team_id == rival }
    end
    ot
  end

  def favorite_opponent(team_id)
    hash = {}
      hash[other_team(team_id)] = (rival_win(team_id).count.to_f/games_shared(team_id).count).round(2)
      answer = hash.min_by {|team, percent| percent}
      a = answer[0][0]
      a.first.team_name
  end

  def rival(team_id)
    rival_hash = {}
      rival_hash[other_team(team_id)] = (rival_win(team_id).count.to_f/games_shared(team_id).count).round(2)
      answer = rival_hash.max_by{|team, percent| percent}
      a = answer.first[0]
      a[0].team_name
  end

  def summary(team_id, postseason, season)
    {
      win_percentage: win_perc_by_season_(team_id, postseason)[season].to_f.round(2),
      total_goals_scored: total_goals_scored(team_id, postseason)[season],
      total_goals_against: total_goals_scored_against(team_id, postseason)[season],
      average_goals_scored: average_goals_scored(team_id, postseason)[season],
      average_goals_against: average_goals_against(team_id, postseason)[season]
    }
  end

  def seasonal_summary(team_id)
    summary = {}
    total_seasons(team_id).each do |season|
      summary[season] = {
        regular_season: summary(team_id, "R", season),
        postseason: summary(team_id, "P", season)
      }
    end
    return summary
  end
end
