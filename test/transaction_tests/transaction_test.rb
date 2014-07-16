require_relative '../test_helper'
require_relative '../../lib/transaction'
require_relative '../../lib/transaction_repository'

class TransactionTest < Minitest::Test
  def setup
    @transaction = Transaction.new(data, @repo_ref)
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
end
