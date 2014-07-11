require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
  def setup
    @merchant = Merchant.new(data, @repo_ref)
  end

  def sales_engine
    @sales_engine ||= begin
      sales_engine = SalesEngine.new('test/fixtures')
      sales_engine.startup
      sales_engine
    end
  end

  def data
    { :id=>         '1',
      :name=>       'Schroeder-Jerde',
      :created_at=> '2012-03-27 14:53:59 UTC',
      :updated_at=> '2012-03-27 14:53:59 UTC'
    }
  end

  def test_it_has_attributes
    @merchant.id
    @merchant.name
    @merchant.created_at
    @merchant.updated_at
  end

  def test_a_merchant_knows_its_attributes
    assert_equal 1,                 @merchant.id
    assert_equal 'Schroeder-Jerde', @merchant.name
  end

  def test_returns_correct_number_of_items
    @merchant_test = sales_engine.merchant_repository.find_by_id(3)
    results        = @merchant_test.items

    assert_equal 4, results.count
  end

  def test_returns_correct_number_of_invoices_for_merchant
    @merchant_test = sales_engine.merchant_repository.find_by_id(3)
    results        = @merchant_test.invoices

    assert_equal 3, results.count
  end

  def test_returns_total_revenue_for_a_merchant_across_all_transactions
    @merchant_test = sales_engine.merchant_repository.find_by_name('Willms and Sons')
    result         = @merchant_test.revenue

    assert_equal   BigDecimal("186.71").to_s, result.to_s
  end

  def test_returns_total_revenue_for_a_merchant_on_particular_date
    @merchant_test = sales_engine.merchant_repository.find_by_name('Cummings-Thiel')
    date           = Date.parse('2012-03-24 15:54:10 UTC')
    result         = @merchant_test.revenue(date)

    assert_equal   BigDecimal("186.71").to_s, result.to_s
  end

  def test_returns_customer_with_most_successful_transactions
    @merchant_test = sales_engine.merchant_repository.find_by_name('Willms and Sons')
    result         = @merchant_test.favorite_customer

    assert_equal 'Cecelia', result.first_name
  end

  def test_customers_with_pending_invoices_returns_a_collection_of_Customer_instances_which_have_unpaid_invoices
    @merchant_test = sales_engine.merchant_repository.find_by_name('Marvin Group')
    results        = @merchant_test.customers_with_pending_invoices

    assert_equal ['Logan', 'Mariah'], results.map(&:first_name).sort
  end
end
