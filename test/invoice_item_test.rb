require_relative 'test_helper'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'


class InvoiceItemTest < Minitest::Test
  def setup
    @invoice_item = InvoiceItem.new(data, @repo_ref)
  end

  def data
    { :id=>          '1',
      :item_id=>     '539',
      :invoice_id=>  '1',
      :quantity=>    '5',
      :unit_price=>  '13635',
      :created_at=>  '2012-03-27 14:54:09 UTC',
      :updated_at=>  '2012-03-27 14:54:09 UTC'
    }
  end

  def sales_engine
    @sales_engine ||= begin
      sales_engine = SalesEngine.new('test/fixtures')
      sales_engine.startup
      sales_engine
    end
  end

  def test_an_invoice_item_has_attributes
    @invoice_item.id
    @invoice_item.item_id
    @invoice_item.invoice_id
    @invoice_item.quantity
    @invoice_item.unit_price
    @invoice_item.created_at
    @invoice_item.updated_at
  end

  def test_an_invoice_item_knows_its_attributes
    assert_equal 1,                    @invoice_item.id
    assert_equal 539,                  @invoice_item.item_id
    assert_equal 1,                    @invoice_item.invoice_id
    assert_equal '5',                  @invoice_item.quantity
    assert_equal BigDecimal("136.35"), @invoice_item.unit_price
  end

  def test_returns_correct_item_for_invoice_items
    @invoice_item_test = sales_engine.invoice_item_repository.find_by_id(5)
    result             = @invoice_item_test.item

    assert_equal 'Item Eius Et', result.name
  end

  def test_returns_correct_invoice_for_invoice_items
    @invoice_item_test = sales_engine.invoice_item_repository.find_by_id(5)
    result             = @invoice_item_test.invoice

    assert_equal 26, result.merchant_id
  end
end
