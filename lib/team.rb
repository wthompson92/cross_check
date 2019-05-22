<<<<<<< HEAD
class Teams
  def initialize(hash)
    @hash = hash
  end
=======
require 'pry'
require 'csv'

class Team

  def initialize(row)
    @team_id = row[:team_id]
    @franchise_id = row[:franchiseid]
    @short_name = row[:shortname]
    @team_name = row[:teamname]
    @abbreviation = row[:abbreviation]
    @link = row[:link]
  end

>>>>>>> 6c5100dcefa23998f4b979e24d22787bcd950e8e
end
