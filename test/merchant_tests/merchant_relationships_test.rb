require_relative '../test_helper'
require_relative '../../lib/merchant'
require_relative '../../lib/merchant_repository'
require_relative '../../lib/sales_engine'

class MerchantRelationshipsTest < Minitest::Test
  def sales_engine
    @sales_engine ||= begin
      sales_engine = SalesEngine.new('../test/fixtures')
      sales_engine.startup
      sales_engine
    end
  end

  def test_returns_correct_number_of_items
    merchant_test = sales_engine.merchant_repository.find_by_id(3)
    results        = merchant_test.items

    assert_equal 4, results.count
  end

  def test_returns_correct_number_of_invoices_for_merchant
    merchant_test = sales_engine.merchant_repository.find_by_id(3)
    results       = merchant_test.invoices

    assert_equal 3, results.count
  end
end
