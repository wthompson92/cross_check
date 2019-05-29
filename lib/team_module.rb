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

  def games_played_by_season(team_id, postseason)
    games_by_season = games_played(team_id).group_by do |game|
      game.season
    end
    season_games = games_by_season.each do |season, games_in_season|
      games_by_season[season] = games_in_season.length
    end
    season_games
  end

  def win_perc_by_season(team_id)
    regular = win_perc_by_season_(team_id, "R")
    post = win_perc_by_season_(team_id, "P")
    regular.merge(post){|key, oldval, newval| ((newval + oldval) / 2).to_i}
  end

  def win_perc_by_season_(team_id, postseason)
    win_percent_by_season = {}
    total_seasons(team_id).find_all do |season|
      wins = 0
      games_by_season = 0
      games_played(team_id).find_all do |game|
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
    winning_percentages = win_perc_by_season(team_id)
    winning_percentages.max_by { |season, win_percent| win_percent }.first
  end

  def worst_season(team_id)
    winning_percentages = win_perc_by_season(team_id)
    winning_percentages.min_by { |season, win_percent| win_percent }.first
  end

  def average_win_percentage(team_id)
    seasons = total_seasons(team_id)
    games = games_played(team_id)
    winning_percentages = win_perc_by_season(team_id)
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
    team_outcomes(team_id).map do |outcome|
      outcome[0] - outcome[1]
    end.max
  end

  def worst_loss(team_id)
    team_outcomes(team_id).map do |outcome|
      outcome[1] - outcome[0]
    end.max
  end

  def head_to_head
    # Record (as a hash - win/loss) against all opponents with the opponents’
    # names as keys and the win percentage against that opponent as a value
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

  # def total_goals_scored_by_reg(team_id)
  #   total_goals_scored(team_id, "R")
  # end

  # def total_goals_scored_by_post(team_id)
  #   total_goals_scored(team_id, "P")
  # end

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

  def total_goals_scored_against_reg(team_id)
    total_goals_scored_against(team_id, "R")
  end

  def total_goals_scored_against_post(team_id)
    total_goals_scored_against(team_id, "P")
  end

  # def average_goals_scored_reg(team_id)
  #   average = {}
  #   total_goals_scored(team_id, "R").each do |season, goals|
  #     average[season] = goals / games_played_by_season(team_id, "R")[season]
  #   end
  #   average
  # end

  def average_goals_scored(team_id, postseason)
    average = {}
    total_goals_scored(team_id, postseason).each do |season, goals|
      average[season] = goals / games_played_by_season(team_id, postseason)[season]
    end
    average
  end

  def average_goals_against(team_id, postseason)
    average = {}
    total_goals_scored_against(team_id, postseason).each do |season, goals|
      average[season] = goals / games_played_by_season(team_id, postseason)[season]
    end
    average
  end


  def summary(team_id, postseason, season)
    {
      win_percentage: win_perc_by_season_(team_id, postseason)[season],
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
        #   win_percentage: win_perc_by_season_(team_id, "R")[season],
        #   total_goals_scored: total_goals_scored(team_id, p)[season],
        #   total_goals_against: total_goals_scored_against_reg(team_id)[season],
        #   average_goals_scored: average_goals_scored_reg(team_id)[season],
        #   average_goals_against: average_goals_against_reg(team_id)[season]

        post_season: summary(team_id, "P", season)
        # {
          # win_percentage: win_perc_by_season_(team_id, "P")[season],
          # total_goals_scored: total_goals_scored_by_post(team_id)[season],
          # total_goals_against: total_goals_scored_against_post(team_id)[season],
          # average_goals_scored: average_goals_scored_post(team_id)[season],
          # average_goals_against: average_goals_against_post(team_id)[season]
        # }
    }
    end
    return summary
  end
end
