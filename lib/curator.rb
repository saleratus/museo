class Curator
  attr_reader :artists, :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo_attribs)
    @photographs << Photograph.new(photo_attribs)
  end

  def add_artist(artist_attribs)
    @artists << Artist.new(artist_attribs)
  end

  def find_artist_by_id(id_string)
    @artists.find { |artist| artist.id == id_string }
  end

  def find_photograph_by_id(id_string)
    @photographs.find { |photo| photo.id == id_string }
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
      photo.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    multi_artists = []
    @artists.each do |artist|
      if find_photographs_by_artist(artist).count > 1
        multi_artists << artist
      end
    end
    multi_artists
  end

  def photographs_taken_by_artists_from(country)
    country_photos = []
    @photographs.each do |photo|
      artist = find_artist_by_id(photo.artist_id)
      country_photos << photo if artist.country == country
    end
    country_photos
  end

end
