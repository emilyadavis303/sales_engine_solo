require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
  def setup
    @customer = Customer.new(data, @repo_ref)
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
      :first_name=> 'Joey',
      :last_name=>  'Ondricka',
      :created_at=> '2012-03-27 14:54:09 UTC',
      :updated_at=> '2012-03-27 14:54:09 UTC'
    }
  end

  def test_a_customer_has_attributes
    @customer.id
    @customer.first_name
    @customer.last_name
    @customer.created_at
    @customer.updated_at
  end

  def test_a_customer_knows_its_attributes
    assert_equal 1,          @customer.id
    assert_equal 'Joey',     @customer.first_name
    assert_equal 'Ondricka', @customer.last_name
  end

  def test_it_can_return_correct_number_of_invoices_for_customer
    @customer_test = sales_engine.customer_repository.find_by_id(5)
    results        = @customer_test.invoices

    assert_equal 4, results.count
  end

  def test_returns_favorite_merchant
    @customer_test = sales_engine.customer_repository.find_by_id(5)
    result         = @customer_test.favorite_merchant

    assert_equal 'Cummings-Thiel', result.name
  end

  def test_returns_all_transactions_for_a_customer
    @customer_test = sales_engine.customer_repository.find_by_id(5)
    results        = @customer_test.transactions

    assert_equal 3, results.count
  end
end
