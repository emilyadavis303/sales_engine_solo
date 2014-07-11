require './test/test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    engine = SalesEngine.new('test/fixtures')
    engine.startup
    @repo ||= InvoiceItemRepository.new(engine, 'test/fixtures')
  end

  def test_it_exists
    assert @repo
  end

  def test_a_repository_loads_invoice_items
    assert @repo.count >= 10
  end

  def test_can_lookup_invoice_item_by_id
    result = @repo.find_by_item_id(534)

    assert_equal '6',        result.quantity
    assert_equal BigDecimal, result.unit_price.class
  end

  def test_can_lookup_item_by_quantity
    result = @repo.find_all_by_quantity(6)

    assert_equal 2, result.count
  end

  def test_can_lookup_item_by_invoice_id
    result = @repo.find_by_id(9)

    assert_equal 1832, result.item_id
  end
end
