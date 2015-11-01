class DocumentoContable < ActiveRecord::Base
  self.abstract_class = true

  @@sistema = ""

  belongs_to :comerciante, :polymorphic => true
  belongs_to :sucursal
  belongs_to :moneda


end
