require_relative '../test_helper'
require_relative '../../lib/merchant'
require_relative '../../lib/merchant_repository'
require_relative '../../lib/sales_engine'

class MerchantTest < Minitest::Test
  def setup
    @merchant = Merchant.new(data, @repo_ref)
  end

  def data
    { :id=>         '1',
      :name=>       'Schroeder-Jerde',
      :created_at=> '2012-03-27 14:53:59 UTC',
      :updated_at=> '2012-03-27 14:53:59 UTC'
    }
  end

  def test_it_has_attributes
    assert  @merchant.id
    assert  @merchant.name
    assert  @merchant.created_at
    assert  @merchant.updated_at
  end

  def test_a_merchant_knows_its_attributes
    assert_equal 1,                 @merchant.id
    assert_equal 'Schroeder-Jerde', @merchant.name
  end
end
