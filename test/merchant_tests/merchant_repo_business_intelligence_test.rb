require_relative '../test_helper'
require_relative '../../lib/merchant_repository'
require_relative '../../lib/sales_engine'

class MerchantRepoBusinessIntelligenceTest < Minitest::Test
  def setup
    engine = SalesEngine.new('../test/fixtures')
    engine.startup
    @repo ||= MerchantRepository.new(engine, '../test/fixtures')
  end

  def test_it_returns_total_revenue_across_all_merchants_for_a_particular_date
    results = @repo
    date    = Date.parse('2012-03-24 15:54:10 UTC')

    assert_equal BigDecimal("186.71"), results.revenue(date)
  end
end
