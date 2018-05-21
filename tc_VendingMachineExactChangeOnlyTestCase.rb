require_relative "CoinClass"
require_relative "VendingMachineTestClass"

class ExactChangeOnly < VendingMachineTest

  def test_ExactChangeOnlyNoDimesOneNickelsDisplayExactChangeOnly
    @vending_machine.adjustDimeBank(-10)
    @vending_machine.adjustNickelBank(-9)
    assert_equal("EXACT CHANGE ONLY", @vending_machine.checkDisplay())
  end

  def test_ExactChangeOnlyNoNickels1DimeDisplayInsertCoin
    @vending_machine.adjustDimeBank(-9)
    @vending_machine.adjustNickelBank(-10)
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def test_ExactChangeOnly2NickelsNoDimesDisplayInsertCoin
    @vending_machine.adjustDimeBank(-10)
    @vending_machine.adjustNickelBank(-8)
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

end
