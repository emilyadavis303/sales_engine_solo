require_relative '../test_helper'
require_relative '../../lib/transaction'
require_relative '../../lib/transaction_repository'
require_relative '../../lib/sales_engine'

class TransactionTest < Minitest::Test
  def sales_engine
    @sales_engine ||= begin
      sales_engine = SalesEngine.new('../test/fixtures')
      sales_engine.startup
      sales_engine
    end
  end

  def test_it_can_find_invoice_for_transaction
    transaction_test = sales_engine.transaction_repository.find_by_id(3)
    result           = transaction_test.invoice

    assert_equal 75, result.merchant_id
  end
end
