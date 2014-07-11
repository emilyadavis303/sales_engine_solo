require 'date'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repo_ref

  def initialize(row, repo_ref)
    @id            = row[:id].to_i
    @customer_id   = row[:customer_id].to_i
    @merchant_id   = row[:merchant_id].to_i
    @status        = row[:status]
    @created_at    = Date.parse(row[:created_at])
    @updated_at    = Date.parse(row[:updated_at])
    @repo_ref      = repo_ref
  end

  def customer
    repo_ref.engine.customer_repository.find_by_id(@customer_id)
  end

  def transactions
    repo_ref.engine.transaction_repository.find_all_by_invoice_id(@id)
  end

  def successful_transactions
    transactions.select {|it| it.result == 'success'}
  end

  def successful?
    successful_transactions.any?
  end

  def items
    list_of_ii = invoice_items
    list_of_ii.map do |ii|
      repo_ref.engine.item_repository.find_by_id(ii.item_id)
    end
  end

  def merchant
    repo_ref.engine.merchant_repository.find_by_id(@merchant_id)
  end

  def invoice_items
    repo_ref.engine.invoice_item_repository.find_all_by_invoice_id(@id)
  end

  def total
    invoice_items.reduce(0) {|total, invoice_item| total += invoice_item.total}
  end

end
