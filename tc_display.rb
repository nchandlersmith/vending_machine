require_relative "display"
require "test/unit"

class TestDisplay < Test::Unit::TestCase

  def setup
    @display = Display.new()
  end

  def test_DisplayTextInitializesToInsertCoin
    assert_equal("INSERT COIN", @display.getDisplayText())
  end

  def test_DisplayTextSetToThankYou
    @display.setDisplayText("THANK YOU")
    assert_equal("THANK YOU", @display.getDisplayText())
  end

end
