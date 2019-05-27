module SeasonModule


  def convert_id_to_name(team_id)
    teams.find do |team|
      if team.team_id == team_id.to_i
       return team.team_name
      end
    end
  end

  def get_all_games_by_season(season_id)
    games.find_all do |game|
       game.season == season_id
     end
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
      percentage = (win_count /  game_count.to_f * 100).round(2)
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
    convert_id_to_name(team_id)
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
    convert_id_to_name(team_id)
  end

  def winningest_coach_for_season(season_id)
  end

  def worst_coach(season_id)
  end

  def find_games_in_game_teams_by_season(season_id)
    game_teams.find_all do |game_team|
      get_all_games_by_season(season_id).any? do |game|
        game_team.game_id == game.game_id
      end
    end
  end

  def most_accurate_team(season_id)
    most = accuracy_by_team_by_season(season_id).max_by { |k,v| v }
    convert_id_to_name(most.first)
  end

  def least_accurate_team(season_id)
    least = accuracy_by_team_by_season(season_id).min_by { |k,v| v }
    convert_id_to_name(least.first)
  end

  def hits_per_game_per_season(season_id)
    hits = {}
    find_games_in_game_teams_by_season(season_id).each do |game|
      hits[game.team_id] = game.hits
    end
    hits
  end

  def most_hits(season_id)
    most = hits_per_game_per_season(season_id).max_by { |k,v,| v }
    convert_id_to_name(most.first)
  end

  def fewest_hits(season_id)
    fewest = hits_per_game_per_season(season_id).min_by { |k,v,| v }
    convert_id_to_name(fewest.first)
  end

  def power_play_goal_percentage(season_id)
    opportunities = find_games_in_game_teams_by_season(season_id).sum do |game|
      game.power_play_opportunities
    end
    goals = find_games_in_game_teams_by_season(season_id).sum do |game|
      game.power_play_goals
    end
    (goals / opportunities * 100).round(2)
  end
end
