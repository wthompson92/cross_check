class StatTracker

  def initialize(locations)
    @game = game
    
  end

  def self.from_csv(locations)
    CSV.table(locations)

    # locations.each do |location|
    end
  end



  # @games << Game.new(row)
