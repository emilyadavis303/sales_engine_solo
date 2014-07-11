require 'csv'
require_relative 'customer'
require_relative 'parser'

class CustomerRepository
  attr_reader   :customers,
                :engine

  def initialize(engine, data_path='./data')
    @customers = Parser.new.parse(data_path + '/customers.csv', Customer, self)
    @engine    = engine
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def random
    customers.shuffle.first
  end

  def all
    customers
  end

  def find_by_last_name(last_name)
    customers.find do
      |customer| customer.last_name.downcase == last_name.downcase
    end
  end

  def find_all_by_first_name(first_name)
    customers.find_all do
      |customer| customer.first_name.downcase == first_name.downcase
    end
  end

  def find_by_id(id)
    customers.find do
      |customer| customer.id.to_s == id.to_s
    end
  end

  def count
    customers.count
  end
end
