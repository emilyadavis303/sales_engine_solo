require 'date'
require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repo_ref

  def initialize(row, repo_ref)
    @id          = row[:id].to_i
    @name        = row[:name]
    @description = row[:description]
    @unit_price  = BigDecimal.new(row[:unit_price])/100
    @merchant_id = row[:merchant_id].to_i
    @created_at  = Date.parse(row[:created_at])
    @updated_at  = Date.parse(row[:updated_at])
    @repo_ref    = repo_ref
  end

  def invoice_items
    repo_ref.engine.invoice_item_repository.find_all_by_item_id(@id)
  end

  def merchant
    repo_ref.engine.merchant_repository.find_by_id(@merchant_id)
  end
end
