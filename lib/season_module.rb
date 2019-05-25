module SeasonModule

  def group_by_season(season_id)
    by_season = game_teams.find_all do |stat|
       stat.season_id == season_id
     end
       by_season.group_by do |instance|
         instance.game_id
       end 
     end
   end

  def playoff_v_reg_percentage_by_season
  def biggest_bust(season_id)
     group_by(season_id)

  end

  def biggest_surprise(season_id)

  end

  def winningest_coach_for_season(season_id)

  end

  def worst_coach(season_id)
  end


  def most_accurate_team(season_id)(season_id)
  end

  def least_accurate_team(season_id)
  end

  def most_hits(season_id)
  end

  def fewest_hits(season_id)
  end

  def power_play_goal_percentage(season_id)
  end
end
