require_relative '../test_helper'
require_relative '../../lib/transaction_repository'
require_relative '../../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @repo ||= TransactionRepository.new(@engine, '../test/fixtures')
  end

  def test_it_loads_all_transactions
    results = @repo.all

    assert_equal 16, results.count
  end

  def test_it_can_find_a_transaction_by_cc_number
    result = @repo.find_by_credit_card_number('4140149827486249')

    assert_equal 9,                  result.id
    assert_equal '4140149827486249', result.credit_card_number
  end

  def test_it_can_find_all_by_result
    result = @repo.find_all_by_result('success')

    assert_equal 13, result.count
  end

  def test_it_can_find_a_transaction_by_id
    result = @repo.find_by_id(5)

    assert_equal 6,                  result.invoice_id
    assert_equal '4844518708741275', result.credit_card_number
  end
end
