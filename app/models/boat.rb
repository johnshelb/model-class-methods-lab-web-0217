class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where ("length >= 20")
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)  #Boat.order("name desc").limit(3) also works as does order("name desc").limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

   def self.sailboats
    joins(:classifications).where("classifications.name = ?",'Sailboat')
   end
   #joins(:classifications).where(classifications: {name: "Sailboat"})
   #includes(:classifications).where(classifications: {name: "Sailboat"})  using includes instead of joins gets rid of n+1 problem

   def self.with_three_classifications
     joins(:classifications).group("boats.name").having("count(*) = ?",3)
     #joins(:boat_classifications).group(:name).having("count(*) = ?",3) also works
   end
end
