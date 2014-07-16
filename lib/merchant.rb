require 'date'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_repo

  def initialize(row, repo_ref)
    @id             = row[:id].to_i
    @name           = row[:name]
    @created_at     = Date.parse(row[:created_at])
    @updated_at     = Date.parse(row[:updated_at])
    @merchant_repo  = repo_ref
  end

  # relationships
  def items
    merchant_repo.find_items_for_merchant(id)
  end

  def invoices
    merchant_repo.find_invoices_for_merchant(id)
  end

  def successful_invoices
    merchant_repo.find_successful_invoices_for_merchant_id(id)
  end

  # business intelligence
  def revenue(date=nil)
    # scoped_invoices = successful_invoices
    scoped_invoices = invoices.select(&:successful?)
    date && scoped_invoices.select! { |invoice| invoice.updated_at == date }
    scoped_invoices.map(&:total).reduce(:+)
  end

  def favorite_customer
    scoped_invoices  = invoices.select(&:successful?)
    grouped_invoices = scoped_invoices.group_by do
      |invoice| invoice.customer_id
    end

    customer_id = grouped_invoices.max_by { |key, values| values.count }.first

    merchant_repo.engine.customer_repository.find_by_id(customer_id)
  end

  def customers_with_pending_invoices
    pending_invoices = invoices.select do
      |invoice| invoice.successful_transactions.none?
    end

    pending_invoices.collect { |invoice| invoice.customer }
  end
end
