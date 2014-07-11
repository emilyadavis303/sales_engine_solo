require 'bigdecimal'
require 'date'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :repo_ref

  def initialize(row, repo_ref)
    @id            = row[:id].to_i
    @item_id       = row[:item_id].to_i
    @invoice_id    = row[:invoice_id].to_i
    @quantity      = row[:quantity]
    @unit_price    = BigDecimal.new(row[:unit_price])/100
    @created_at    = Date.parse(row[:created_at])
    @updated_at    = Date.parse(row[:updated_at])
    @repo_ref      = repo_ref
  end

  def item
    repo_ref.engine.item_repository.find_by_id(@item_id)
  end

  def invoice
    repo_ref.engine.invoice_repository.find_by_id(@invoice_id)
  end

  def total
    quantity.to_i * unit_price
  end

end
