require_relative '../test_helper'
require_relative '../../lib/merchant'
require_relative '../../lib/merchant_repository'
require_relative '../../lib/sales_engine'

class MerchantBusinessIntelligenceTest < Minitest::Test
  def sales_engine
    @sales_engine ||= begin
      sales_engine = SalesEngine.new('../test/fixtures')
      sales_engine.startup
      sales_engine
    end
  end

  def test_returns_total_revenue_for_a_merchant_across_all_transactions
    merchant_test = sales_engine.merchant_repository.find_by_name('Willms and Sons')
    result         = merchant_test.revenue

    assert_equal   BigDecimal("186.71").to_s, result.to_s
  end

  def test_returns_total_revenue_for_a_merchant_on_particular_date
    merchant_test = sales_engine.merchant_repository.find_by_name('Cummings-Thiel')
    date           = Date.parse('2012-03-24 15:54:10 UTC')
    result         = merchant_test.revenue(date)

    assert_equal   BigDecimal("186.71").to_s, result.to_s
  end

  def test_returns_customer_with_most_successful_transactions
    merchant_test = sales_engine.merchant_repository.find_by_name('Willms and Sons')
    result         = merchant_test.favorite_customer

    assert_equal 'Cecelia', result.first_name
  end

  def test_customers_with_pending_invoices_returns_a_collection_of_Customer_instances_which_have_unpaid_invoices
    merchant_test = sales_engine.merchant_repository.find_by_name('Marvin Group')
    results        = merchant_test.customers_with_pending_invoices

    assert_equal ['Logan', 'Mariah'], results.map(&:first_name).sort
  end
end
