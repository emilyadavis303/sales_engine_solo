require 'date'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repo_ref

  def initialize(row, repo_ref)
    @id           = row[:id].to_i
    @name         = row[:name]
    @created_at   = Date.parse(row[:created_at])
    @updated_at   = Date.parse(row[:updated_at])
    @repo_ref     = repo_ref
  end

  def items
    repo_ref.engine.item_repository.find_all_by_merchant_id(@id)
  end

  def invoices
    repo_ref.engine.invoice_repository.find_all_by_merchant_id(@id)
  end

  def revenue(date=nil)
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

    repo_ref.engine.customer_repository.find_by_id(customer_id)
  end

  def customers_with_pending_invoices
    pending_invoices = invoices.select do
      |invoice| invoice.successful_transactions.none?
    end

    pending_invoices.collect { |invoice| invoice.customer }
  end
end
