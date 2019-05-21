class StatTracker

  def initialize(locations)
    @game_path = game_path
    @team_path =
    @game_teams_path =
    @location
  end

  def self.from_csv(locations)
    CSV.table(locations)

    # locations.each do |location|
    end
  end



  # @games << Game.new(row)
