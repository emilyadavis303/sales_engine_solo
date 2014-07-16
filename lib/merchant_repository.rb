require 'csv'
require_relative 'merchant'
require_relative 'parser'

class MerchantRepository
  attr_reader   :merchants,
                :engine

  def initialize(engine, data_path='./data')
    @merchants = Parser.new.parse(data_path + '/merchants.csv', Merchant, self)
    @engine    = engine
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def random
    merchants.sample
  end

  def all
    merchants
  end

  # finder methods
  def find_by_id(id)
    merchants.find do
      |merchant| merchant.id == id
    end
  end

  def find_by_name(name)
    merchants.find do
      |merchant| merchant.name == name
    end
  end

  def find_all_by_name(name)
    merchants.find_all do
      |merchant| merchant.name == name
    end
  end

  # relationships
  def find_items_for_merchant(id)
    engine.find_items_for_merchant(id)
  end

  def find_invoices_for_merchant(id)
    engine.find_invoices_for_merchant(id)
  end

  # business intelligence
  def revenue(date)
    all_revenue = merchants.map do
      |merchant| merchant.revenue(date)
    end

    all_revenue.compact.reduce(0, :+)
  end

  # count method for tests
  def count
    merchants.count
  end
end
