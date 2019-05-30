require 'pry'

module LeagueModule

  def get_teams
    team_ids = []
    games.each do |game|
      team_ids << game.away_team_id
      team_ids << game.home_team_id
    end
    team_ids.uniq
  end

  def count_of_teams
    get_teams.count
  end

  def convert_id_to_name(team_id)
    teams.find do |team|
      if team.team_id == team_id
       return team.team_name
      end
    end
  end

  def number_of_games_total_played_by_each_team
    hash = Hash.new(0)
    get_teams.each do |id|
      games.each do |game|
        if (game.home_team_id || game.away_team_id) == (id)
          hash[id] += 1
        end
      end
    end
  hash
  end

  def total_scored_on_by_team
    scored_on = Hash.new(0)
    get_teams.each do |team|
      games.each do |game|
        if game.home_team_id == team
          scored_on[team] += game.away_goals
        elsif game.away_team_id == team
          scored_on[team] += game.home_goals
        end
      end
    end
    scored_on
  end

  def average_goals_allowed
    number = number_of_games_total_played_by_each_team
    total_scored_on_by_team.merge(number) do |k, scored_on, game|
      scored_on / game.to_f
    end
  end

  def home_goals_by_team
    home_goals = Hash.new(0)
    get_teams.each do |id|
      games.each do |game|
        if game.home_team_id == (id)
          home_goals[id] += game.home_goals
        end
      end
    end
    home_goals
  end

  def away_goals_by_team
    away_goals = Hash.new(0)
    get_teams.each do |id|
      games.each do |game|
        if game.away_team_id == (id)
          away_goals[id] += game.away_goals
        end
      end
    end
    away_goals
  end

  def total_goals_scored_by_each_team
    home_goals_by_team.merge(away_goals_by_team)
  end

  def best_offense
    hash = Hash.new
    total_goals_scored_by_each_team.map do |key, value|
      number_of_games_total_played_by_each_team.map do |k, v|
        hash[key] = value / v.to_f
      end
    end
    convert_id_to_name(hash.max.first)
  end

  def worst_offense
    hash = Hash.new
    total_goals_scored_by_each_team.map do |key, value|
      number_of_games_total_played_by_each_team.map do |k, v|
        hash[key] = value / v.to_f
      end
    end
    convert_id_to_name(hash.min.first)
  end

  def best_defense
    best = average_goals_allowed.min_by { |k,v| v }
    convert_id_to_name(best.first)
  end

  def worst_defense
    worst = average_goals_allowed.max_by { |k,v| v }
    convert_id_to_name(worst.first)
  end

  def average_goals_scored_by_home_team
    home = Hash.new
    hash = games.group_by{ |game| game.home_team_id }
      hash.each do |team_id, games|
        goals = games.map{ |game| game.home_goals }
        goals = (goals.sum / goals.count.to_f).round(2)
        home[team_id] = goals
      end
    home
  end

  def average_goals_scored_by_away_team
    away = Hash.new
    hash = games.group_by{ |game| game.away_team_id }
      hash.each do |team_id, games|
        goals = games.map{ |game| game.away_goals }
        goals = (goals.sum / goals.count.to_f).round(2)
        away[team_id] = goals
      end
    away
  end

  def highest_scoring_visitor
      team_id = average_goals_scored_by_away_team.max_by{ |team_id, goals| goals }.first
      convert_id_to_name(team_id)
  end

  def lowest_scoring_visitor
      team_id = average_goals_scored_by_away_team.min_by{ |team_id, goals| goals }.first
      convert_id_to_name(team_id)
  end

  def highest_scoring_home_team
    home = average_goals_scored_by_home_team
    team_id = home.max_by{ |team_id, goals| goals }.first
    convert_id_to_name(team_id)
  end

  def lowest_scoring_home_team
    home = average_goals_scored_by_home_team
    team_id = home.min_by{ |team_id, goals| goals }.first
    convert_id_to_name(team_id)
  end

  def win_percentage_by_team
    win_per_by_team = {}
    @teams.each do |teams|
      relevant_games = []
      @game_teams.each do |games|
        if teams.team_id == games.team_id
          relevant_games << games
        end
      end
      wins = []
      relevant_games.each do |stat|
        if stat.won == "TRUE"
          wins << stat
        end
      end
        final = (wins.count/relevant_games.count.to_f).round(2)
        final = 0.000001 if final.nan?
        win_per_by_team[teams.team_name] = final
    end
    win_per_by_team
  end

  def winningest_team
    a = win_percentage_by_team.max_by{|team, percentage| percentage}
    a.first
  end

  def fans
    gamess = @game_teams.group_by{|teams| teams.team_id}
    gamess.transform_values do |games|
    home_wins = 0
    away_wins = 0
    games_played_home = 0
    games_played_away = 0
    games.each do |game|
        home_wins += 1 if game.won == "TRUE" && game.hoa == "home"
        away_wins += 1 if game.won == "TRUE" && game.hoa == "away"
        games_played_home += 1 if game.hoa == "home"
        games_played_away += 1 if game.hoa == "away"
      end
    home_win_percent = (home_wins/games_played_home.to_f).round(2)
    away_win_percent = (away_wins/games_played_away.to_f).round(2)
    fan_per = (home_win_percent - away_win_percent.to_f).round(2)
    end
  end

  def best_fans
    fans.max[0]
  end

  def worst_fans
    fans.min[0]
  end

end
