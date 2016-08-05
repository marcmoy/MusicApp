# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  name       :string           not null
#  album_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ActiveRecord::Base

  ALBUM_TYPES = %w(Live Studio)
  validates :band_id, :name, presence: true
  validates :album_type, inclusion: { in: ALBUM_TYPES }

  belongs_to :band
  has_many :tracks

  def self.years
    @years ||= (1900..Date.today.year).to_a.reverse
  end

  def self.column_data
    reject_columns = %w(id band_id created_at updated_at)
    Album.columns.map(&:name).reject do |col|
      reject_columns.include?(col)
    end
  end

  def self.column_data_headers
    Album.column_data.map do |name|
      name
        .split("_")
        .map(&:capitalize)
        .join(" ")
    end
  end

end
