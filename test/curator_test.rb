require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

require './lib/curator'
require './lib/photograph'
require './lib/artist'



class CuratorTest < Minitest::Test

  def setup
    @photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }

    @photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }

    @photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }

    @photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }



    @artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }

    @artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }

    @artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    @curator = Curator.new
  end

  def extra_setup
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @diane_arbus = @curator.find_artist_by_id("3")
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_artists_array
    assert_equal [], @curator.artists
  end

  def test_photographs_array
    assert_equal [], @curator.photographs
  end

  def test_it_adds_photos
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal 2, @curator.photographs.count
    assert_instance_of Photograph, @curator.photographs.first
    expected = "Rue Mouffetard, Paris (Boy with Bottles)"
    assert_equal expected, @curator.photographs.first.name
  end

  def test_it_adds_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal 2, @curator.artists.count
    assert_instance_of Artist, @curator.artists.first
    expected = "Henri Cartier-Bresson"
    assert_equal expected, @curator.artists.first.name
  end

  def test_it_finds_artists_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal @curator.artists[0], @curator.find_artist_by_id("1")
  end

  def test_it_finds_photos_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal @curator.photographs[1], @curator.find_photograph_by_id("2")
  end

  def test_find_photos_by_artist
    extra_setup
    assert_equal 2, @curator.find_photographs_by_artist(@diane_arbus).count
  end

  def test_it_finds_artists_with_multiple_photos
    extra_setup
    assert_equal 1, @curator.artists_with_multiple_photographs.count
    assert_equal @diane_arbus, @curator.artists_with_multiple_photographs.first
  end

  def test_it_finds_photos_by_artists_from_country
    assert_equal 2, @curator.photographs_taken_by_artists_from("United States").count
    assert_equal 1, @curator.photographs_taken_by_artists_from("Argentina").count
  end

end
