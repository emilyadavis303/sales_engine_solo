require 'date'
require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'


class InvoiceTest < Minitest::Test
  def setup
    @invoice = Invoice.new(data, @repo_ref)
  end

  def data
    { :id=>          '2',
      :customer_id=> '1',
      :merchant_id=> '75',
      :status=>      'shipped',
      :created_at=>  '2012-03-12 05:54:09 UTC',
      :updated_at=>  '2012-03-12 05:54:09 UTC'
    }
  end

  def sales_engine
    @sales_engine ||= begin
      sales_engine = SalesEngine.new('test/fixtures')
      sales_engine.startup
      sales_engine
    end
  end

  def test_an_invoice_has_attributes
    @invoice.id
    @invoice.customer_id
    @invoice.merchant_id
    @invoice.status
    @invoice.created_at
    @invoice.updated_at
  end

  def test_an_invoice_knows_its_attributes
    assert_equal 2,         @invoice.id
    assert_equal 1,         @invoice.customer_id
    assert_equal 75,        @invoice.merchant_id
    assert_equal 'shipped', @invoice.status
  end

  def test_returns_correct_number_of_transactions_for_invoice
    @invoice_test = sales_engine.invoice_repository.find_by_id(2)
    results       = @invoice_test.transactions

    assert 3, results.count
  end

  def test_returns_correct_number_of_invoice_items_for_invoice
    @invoice_test = sales_engine.invoice_repository.find_by_id(1)
    results       = @invoice_test.invoice_items

    assert_equal 9, results.count
  end

  def test_it_can_find_customer_by_id
    @invoice_test = sales_engine.invoice_repository.find_by_id(10)
    result        = @invoice_test.customer

    assert_equal 'Mariah', result.first_name
  end

  def test_it_can_find_a_merchant_associated_with_transaction
    @invoice_test = sales_engine.invoice_repository.find_by_id(5)
    result        = @invoice_test.merchant

    assert_equal 'Willms and Sons', result.name
  end

  def test_returns_collection_of_items_for_invoice
    @invoice_test = sales_engine.invoice_repository.find_by_id(1)
    results       = @invoice_test.items

    assert_equal 9, results.count
    assert results.map(&:name).include? 'Item Quae Dolore'
    assert results.map(&:name).include? 'Item Nulla Aut'
    assert results.map(&:id).include? 539
  end

  def test_returns_invoices_with_successful_transactions
    @invoice_test = sales_engine.invoice_repository.find_by_id(1)
    results       = @invoice_test.successful_transactions

    assert_equal 1, results.count
  end
end
