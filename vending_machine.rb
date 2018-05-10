require_relative "coin"
require_relative "display"

class VendingMachine

  def initialize(displayObject)
    @display = displayObject
  end

  def checkDisplay()
    @display.getDisplayText()
  end

end
