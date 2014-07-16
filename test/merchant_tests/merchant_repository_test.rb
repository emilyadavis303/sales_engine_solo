require_relative '../test_helper'
require_relative '../../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @repo ||= MerchantRepository.new(@engine, '../test/fixtures')
  end

  def test_it_loads_all_merchants
    results = @repo.all

    assert_equal 11, results.count
  end

  def test_it_can_find_a_single_merchant_by_id
    result = @repo.find_by_id(4)

    assert_equal "Cummings-Thiel", result.name
  end

  def test_can_find_a_single_merchant_by_name
    result = @repo.find_by_name('Osinski, Pollich and Koelpin')

    assert_equal 8,                              result.id
    assert_equal 'Osinski, Pollich and Koelpin', result.name
  end

  def test_can_find_all_merchants_by_name
    results = @repo.find_all_by_name('Williamson Group')

    assert_equal 2, results.count
  end
end
