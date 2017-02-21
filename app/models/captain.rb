class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
      joins(boats: :classifications).where(classifications: {name: "Catamaran"}).uniq
  end

  def self.sailors
      joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def  self.talented_seamen
    mb=joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq.pluck(:id)
    s=joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq.pluck(:id)
    where(id: (mb&s))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
