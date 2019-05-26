module SeasonModule


  def convert_id_to_name(team_id)
    teams.find do |team|
      if team.team_id == team_id.to_i
       return team.team_name
      end
    end
  end

  def get_all_game_teams_game_ids
    game_teams.map do |game|
      game.game_id
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
     matching = []
     get_all_game_teams_game_ids.each do |game_team|
     get_all_games_by_season(season_id).each do |game|
       if game.game.id == game_team.id
         matching << game
        end
      end
    end
    matching
   end
 end 

   def worst_coach(season_id)
   end
 end
