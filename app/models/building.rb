class Building < ActiveRecord::Base
  has_many :units
  validates :name, uniqueness: true

  def has_recently_seen_units_with_beds?(beds)
    beds.in?(units.recently_seen.pluck(:beds))
  end

  def recently_seen_starting_rent_for_beds(beds)
    units.recently_seen.where(beds: beds).pluck(:rent).sort.first
  end
end
