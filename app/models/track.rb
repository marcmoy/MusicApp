# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  name       :string           not null
#  lyrics     :text
#  track_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base

  TRACK_TYPES = %w(Regular Bonus)
  validates :album_id, :name, presence: true
  validates :track_type, inclusion: { in: TRACK_TYPES }

  belongs_to :album

  has_one :band,
    through: :album,
    source: :band

  def self.column_data
    reject_columns = %w(id album_id lyrics created_at updated_at)
    Track.columns.map(&:name).reject do |col|
      reject_columns.include?(col)
    end
  end

  def self.column_data_headers
    Track.column_data.map do |name|
      name
        .split("_")
        .map(&:capitalize)
        .join(" ")
    end
  end
end
