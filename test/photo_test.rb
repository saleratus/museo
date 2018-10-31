require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

require './lib/photograph'
#require './lib/artist'

class PhotographTest < Minitest::Test

  def setup
    attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "4",
      year: "1954"
      }
    @photograph = Photograph.new(attributes)
  end

  def test_it_exists
    assert_instance_of Photograph, @photograph
  end

  def test_for_id
    assert_equal 1, @photograph.id
  end

  def test_for_name
    expected = "Rue Mouffetard, Paris (Boy with Bottles)"
    assert_equal expected, @photograph.name
  end

  def test_for_artist_id
    assert_equal "4", @photograph.artist_id
  end

  def test_for_year
    assert_equal "1954", @photograph.year
  end

end
