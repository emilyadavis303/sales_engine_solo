require './test/test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
     @repo ||= begin
       engine = SalesEngine.new('./test/fixtures')
       engine.startup
       engine.merchant_repository
       engine.item_repository
       engine.invoice_repository
       engine.invoice_item_repository
       engine.customer_repository
       engine.transaction_repository
     end
   end

  def test_it_exists
    assert @repo
  end
end
