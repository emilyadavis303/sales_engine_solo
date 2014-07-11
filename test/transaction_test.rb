require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'

class TransactionTest < Minitest::Test
  def setup
    @transaction = Transaction.new(data, @repo_ref)
  end

  def sales_engine
    @sales_engine ||= begin
      sales_engine = SalesEngine.new('test/fixtures')
      sales_engine.startup
      sales_engine
    end
  end

  def data
    { :id=>                '1',
      :invoice_id=>        '1',
      :credit_card_number=>'4654405418249632',
      :result=>            'success',
      :created_at=>        '2012-03-27 14:54:09 UTC',
      :updated_at=>        '2012-03-27 14:54:09 UTC'
    }
  end

  def test_it_has_attributes
    assert @transaction.id
    assert @transaction.invoice_id
    assert @transaction.credit_card_number
    assert @transaction.result
    assert @transaction.created_at
    assert @transaction.updated_at
  end

  def test_a_transaction_knows_its_attributes
    assert_equal 1,                  @transaction.id
    assert_equal 1,                  @transaction.invoice_id
    assert_equal '4654405418249632', @transaction.credit_card_number
    assert_equal 'success',          @transaction.result
  end

  def test_it_can_find_invoice_for_transaction
    @transaction_test = sales_engine.transaction_repository.find_by_id(3)
    result            = @transaction_test.invoice

    assert_equal 75, result.merchant_id
  end
end
