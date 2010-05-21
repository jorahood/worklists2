class IndexWorkshopDocumentAssetOnWfinodeIdAndDocumentId < ActiveRecord::Migration
  def self.up
    add_index WorkshopDocumentAsset.table_name.to_sym, :document
    add_index WorkshopDocumentAsset.table_name.to_sym, :id
  end

  def self.down
    remove_index WorkshopDocumentAsset.table_name.to_sym, :document
    remove_index WorkshopDocumentAsset.table_name.to_sym, :id
  end
end
