# == Schema Information
#
# Table name: renglon_ndc_articulos
#
#  id                 :integer          not null, primary key
#  comercializable_id :integer          not null
#  notadecredito_id   :integer          not null
#  cantidad           :integer          not null
#  precio_unitario    :float            not null
#  total_renglon      :float            not null
#  total_impuestos    :float            not null
#  descuento          :float            default(0.0)
#  comentario         :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class RenglonNdcArticulo < ActiveRecord::Base
  belongs_to :comercializable
  #attr_accessible :cantidad, :comentario, :descuento, :precio, :total_impuestos, :total_renglon
  belongs_to :notadecredito

  has_many :foto_impuesto_ndcs, :as => :renglon, :dependent => :destroy

  def  nombrearticulo
    return self.comercializable.nombreart
  end

  private

  validate :cantidad_val
  validate :ndc_impresa
  validate :comercializable_val
  validates_numericality_of :descuento, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :precio_unitario, :message => "El caracter de separacion decimal es .(Punto)."


  before_destroy :ndc_val?

  def comercializable_val
    if self.id.nil?
      if !self.comercializable.nil? and !self.notadecredito.nil?
        errors.add(:notadecredito,"Ya existe un renglon con el mismo articulo.") if self.notadecredito.renglon_ndc_articulos.where("comercializable_id = ?" , self.comercializable.id.to_s).size() > 0
      end
    else
      if !self.comercializable.nil? and !self.notadecredito.nil?
        errors.add(:notadecredito,"Ya existe un renglon con el mismo articulo.") if self.notadecredito.renglon_ndc_articulos.where("comercializable_id = ? and id <> ?" , self.comercializable.id.to_s,self.id.to_s).size() > 0
      end
    end
  end


  def ndc_val?
    errors.add(:notadecredito, "No puede modificar una Nota de Credito impresa.") if self.notadecredito.impresa?
    errors.blank?
  end

  def cantidad_val
    errors.add(:cantidad,"Debe ingresar una cantidad mayor que cero.") if self.cantidad.nil? || self.cantidad <= 0
  end

  def ndc_impresa
    if !self.notadecredito.nil?
      errors.add(:notadecredito,"No puede modificar una Nota de Credito impresa.") if self.notadecredito.impresa?
    end
  end



end
