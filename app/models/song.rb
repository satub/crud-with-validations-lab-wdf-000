class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: { scope: [:release_year, :artist_name],
    message: "shouldn't be released with same name more than once a year by the same artist" }

  validates :released, inclusion: {in: [true, false]}
  validates :release_year, presence: true, if: :released
  validates :release_year, numericality: true, allow_nil: true

  validates :artist_name, presence: true


  validate :release_year_cannot_be_in_the_distant_future

  def release_year_cannot_be_in_the_distant_future
    if !release_year.nil? && release_year >  DateTime.now.year
      errors.add(:release_year, "can't be in the future")
    end
  end

end
