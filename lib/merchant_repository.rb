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
    merchants.shuffle.first
  end

  def all
    @merchants
  end

  def find_by_id(id)
    merchants.find do
      |merchant| merchant.id.to_s == id.to_s
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

  def revenue(date)
    all_revenue = merchants.map do
      |merchant| merchant.revenue(date)
    end

    all_revenue.compact.reduce(0, :+)
  end

  def count
    merchants.count
  end
end
