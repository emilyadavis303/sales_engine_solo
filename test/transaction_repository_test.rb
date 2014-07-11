require './test/test_helper'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test
  def setup
    engine = SalesEngine.new('test/fixtures')
    engine.startup
    @repo ||= TransactionRepository.new(engine, 'test/fixtures')
  end

  def test_it_exists
    assert @repo
  end

  def test_a_repository_loads_transactions
    assert @repo.count >= 10
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
