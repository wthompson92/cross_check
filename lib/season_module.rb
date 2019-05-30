module SeasonModule

  def convert_id_to_name_season(team_id)
    teams.find do |team|
      if team.team_id == team_id
       return team.team_name
      end
    end
  end


  def get_all_games_by_season(season_id)
    games.find_all do |game|
      game.season == season_id
    end
  end

  def get_all_game_teams_game_ids
    hash = Hash.new
    game_teams.map do |game|
      hash[game.head_coach] = game
    end
    hash
  end

  def playoff_games_by_season(season_id)
    playoff_games = get_all_games_by_season(season_id).find_all do |game|
      game.type == ("P")
    end
    playoff_games.group_by do |game| game.away_team_id || game.home_team_id
    end
  end

  def regular_games_by_season(season_id)
    regular_games = get_all_games_by_season(season_id).find_all do |game|
      game.type == ("R")
    end
    regular_games.group_by do |game| game.away_team_id || game.home_team_id
    end
  end

  def playoff_game_stats(season_id)
    hash = Hash.new
    win_count = 0
    game_count = 0
    playoff_games_by_season(season_id).each do |key, value|
      value.each do |v|
        if ((key == v.away_team_id) && v.outcome.include?("away win"))
          win_count += 1
         game_count += 1
        elsif ((key == v.home_team_id) && (v.outcome.include?("home win")))
          win_count += 1
          game_count += 1
        else
          game_count += 1
        end
        percentage = (win_count / game_count.to_f * 100).round(2)
        hash[key] = percentage
      end
    end
    hash
  end

  def regular_game_stats(season_id)
    hash = Hash.new
    win_count = 0
    game_count = 0
    regular_games_by_season(season_id).each do |key, value|
      value.each do |v|
        if ((key == v.away_team_id) && v.outcome.include?("away win"))
         win_count += 1
          game_count += 1
        elsif ((key == v.home_team_id) && (v.outcome.include?("home win")))
          win_count += 1
          game_count += 1
        else
          game_count += 1
        end
        percentage = (win_count / game_count.to_f * 100).round(2)
        hash[key] = percentage
      end
    end
    hash
  end

  def biggest_bust(season_id)
    hash = Hash.new
    regular_game_stats(season_id).each do |key, value|
      playoff_game_stats(season_id).each do |k, v|
        bust = value - v
        hash[key] = bust
      end
    end
    team_id = hash.max.first
    convert_id_to_name_season(team_id)
  end

  def biggest_surprise(season_id)
    hash = Hash.new
    regular_game_stats(season_id).each do |key, value|
      playoff_game_stats(season_id).each do |k, v|
        surprise = v - value
        hash[key] = surprise
      end
    end
    team_id = hash.min.first
    convert_id_to_name_season(team_id)
  end

  def  away_match_game_and_game_team_data(season_id)
  hash = {}
   get_all_game_teams_game_ids.map do |head_coach, game_team|
     get_all_games_by_season(season_id).map do |game|
      if game.game_id == game_team.game_id && game.away_team_id == game_team.team_id
        hash[head_coach] = game
        end
      end
    end
    hash
  end

  def home_match_game_and_game_team_data(season_id)
   hash = {}
    get_all_game_teams_game_ids.map do |head_coach, game_team|
    get_all_games_by_season(season_id).map do |game|
      if (game.game_id == game_team.game_id) && (game.home_team_id ==   game_team.team_id)
        hash[head_coach] = game
        end
      end
    end
    hash
  end

  def away_winningest_coach_count(season_id)
    coach_wins = Hash.new
    record = []
    away_match_game_and_game_team_data(season_id).each do |key, value|
      record << value.outcome
      wins = record.count do |win|
        win.include?("away win")
      end
      coach_wins[key] = wins
    end
    coach_wins
  end

  def home_winningest_coach_count(season_id)
    coach_wins = Hash.new
    record = []
    home_match_game_and_game_team_data(season_id).each do |key, value|
      record << value.outcome
      wins = record.count do |win|
        win.include?("home win")
      end
      coach_wins[key] = wins
    end
    coach_wins
  end

  def winningest_coach(season_id)
    hash = home_winningest_coach_count(season_id).merge  away_winningest_coach_count(season_id)
    hash.max_by do |k, v| v
    end.first
  end

  def away_worst_coach_count(season_id)
    coach_losses = Hash.new
    record = []
      away_match_game_and_game_team_data(season_id).each do |key, value|
        record << value.outcome
        losses = record.count do |loss|
          loss.include?("home win")
        end
        coach_losses[key] = losses
      end
      coach_losses
  end

  def home_worst_coach_count(season_id)
    coach_losses = Hash.new
    record = []
      home_match_game_and_game_team_data(season_id).each do |key, value|
        record << value.outcome
        losses = record.count do |loss|
          loss.include?("away win")
        end
        coach_losses[key] = losses
      end
      coach_losses
  end

  def worst_coach(season_id)
      hash = home_worst_coach_count(season_id).merge  away_worst_coach_count(season_id)
      hash.max_by do |k, v|  v
      end.first
    end

  def find_games_in_game_teams_by_season(season_id)
    game_teams.find_all do |game_team|
      get_all_games_by_season(season_id).any? do |game|
        game_team.game_id == game.game_id
      end
    end
  end

  def shots_by_season(season_id)
    shots = Hash.new(0)
    find_games_in_game_teams_by_season(season_id).each do |game|
      shots[game.team_id] += game.shots
    end
    shots
  end

  def goals_by_season(season_id)
    goals = Hash.new(0)
    find_games_in_game_teams_by_season(season_id).each do |game|
      goals[game.team_id] += game.goals
    end
    goals
  end

  def accuracy_by_team_by_season(season_id)
    goals = goals_by_season(season_id)
    shots = shots_by_season(season_id)
    goals.merge(shots) do |team, goal, shot|
      goal.to_f / shot
    end
  end

  def most_accurate_team(season_id)
    most = accuracy_by_team_by_season(season_id).max_by { |k,v| v }
    convert_id_to_name_season(most.first)
  end

  def least_accurate_team(season_id)
    least = accuracy_by_team_by_season(season_id).min_by { |k,v| v }
    convert_id_to_name_season(least.first)
  end

  def hits_per_game_per_season(season_id)
    hits = Hash.new(0)
    find_games_in_game_teams_by_season(season_id).each do |game|
      hits[game.team_id] += game.hits
    end
    hits
  end

  def most_hits(season_id)
    most = hits_per_game_per_season(season_id).max_by { |k,v,| v }
    convert_id_to_name_season(most.first)
  end

  def fewest_hits(season_id)
    fewest = hits_per_game_per_season(season_id).min_by { |k,v,| v }
    convert_id_to_name_season(fewest.first)
  end

  def power_play_goal_percentage(season_id)
    goals = find_games_in_game_teams_by_season(season_id).sum do |game|
      game.goals
    end
    power_goals = find_games_in_game_teams_by_season(season_id).sum do |game|
      game.pp_goals
    end
    (power_goals.to_f / goals).round(2)
  end
end
