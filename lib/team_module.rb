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

  def games_shared(team_id)
     sg = []
    rivals(team_id).each do |rival|
       games.each do |game|
          if game.away_team_id == team_id && game.home_team_id == rival
            sg << game
          elsif game.away_team_id == rival && game.home_team_id == team_id
            sg << game
          end
       end
     end
     sg
  end

  def win_perc_by_season(team_id)
    win_perc_by_season_(team_id, "")
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

  def team_jazz(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end
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

  def team_stats_for_game(team_id)
    @game_teams.find_all{ |game| game.team_id == team_id }
  end

  def results_by_rival(team_id)
    games = team_stats_for_game(team_id)
    against{|hash,other_dudes| hash[other_dudes] = {win: 0, lose: 0}}
    games.each do |gamess|
      other_dudes = @game_teams.find do |game|
        game.game_id == gamess.game_id &&
        game.team_id != gamess.team_id
      end.team_id
      outcome = gamess.won ? :win : :lose
      against[other_dudes][outcome] += 1
    end
    return against
  end

  def favorite_opponent
    against = results_by_rival(team_id)
      fav_rival = against.max_by do |other_dudes, game_stats|
         stats[:win] / stats[:lose].to_f
      end[0]
   get_team(fav_rival).team_name
  end

  def rival
    #floats are the worst oh floats are the worst! If i see Nan ever again itll be too soon
    against = results_by_rival(team_id)
      rival_id = against.min_by do |other_dudes, game_stats|
        stats[:win] / stats[:lose].to_f
      end[0]
    get_team(rival_id).team_name
  end

  def head_to_head
    #I hate this method so much oh good god. I hate you please die in a fire.
    heads = {}
    results_by_rival(team_id).each do |other_dudes_id,outcome|
      other_name = team_jazz(other_id).team_name
      games_played = outcome[:win] + outcome[:loss].to_f
      heads[other_name] = (outcome[:win] / games_played).round(2)
    end
    heads
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
