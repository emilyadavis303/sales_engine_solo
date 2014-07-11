require 'csv'
require 'date'
require 'time'
require_relative 'invoice'
require_relative 'parser'

class InvoiceRepository
  attr_reader   :invoices,
                :engine

  def initialize(engine, data_path='./data')
    @invoices = Parser.new.parse(data_path + '/invoices.csv', Invoice, self)
    @engine   = engine
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def random
    invoices.shuffle.first
  end

  def all
    invoices
  end

  def find_by_status(status)
    invoices.find do
      |invoice| invoice.status == status
    end
  end

  def find_all_by_status(status)
    invoices.find_all do
      |invoice| invoice.status == status
    end
  end

  def find_by_id(id)
    invoices.find do
      |invoice| invoice.id == id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all do
      |invoice| invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all do
      |invoice| invoice.customer_id == customer_id
    end
  end

  def find_all_by_date(created_at)
    invoices.find_all do
      |invoice| invoice.created_at == created_at
    end
  end

  def count
    invoices.count
  end
end
