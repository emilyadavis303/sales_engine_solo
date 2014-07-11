require './test/test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  def setup
    engine = SalesEngine.new('test/fixtures')
    engine.startup
    @repo ||= ItemRepository.new(engine, 'test/fixtures')
  end

  def test_it_exists
    assert @repo
  end

  def test_a_repository_loads_merchants
    assert @repo.count >= 10
  end

  def test_find_single_item_by_name
    result = @repo.find_by_name('Item Expedita Aliquam')

    assert_equal 5,                       result.id
    assert_equal 'Item Expedita Aliquam', result.name
  end

  def test_find_all_by_name
    results = @repo.find_all_by_name('Item Autem Minima')

    assert_equal 2, results.count
  end

  def test_find_by_unit_price
    result = @repo.find_by_unit_price(BigDecimal.new("521.00"))

    assert_equal 'Item Aliquid Occaecati', result.name
  end
end
