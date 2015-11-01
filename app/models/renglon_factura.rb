# == Schema Information
#
# Table name: renglon_facturas
#
#  id                 :integer          not null, primary key
#  factura_id         :integer          not null
#  total_renglon      :float            not null
#  total_impuestos    :float            not null
#  comercializable_id :integer          not null
#  cantidad           :integer          not null
#  precio_unitario    :float            not null
#  descuento          :float            default(0.0)
#  comentario         :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class RenglonFactura < ActiveRecord::Base

  belongs_to :factura
  belongs_to :comercializable
  has_many :foto_impuesto_facts, :as => :renglon, :dependent => :destroy

  def  nombrearticulo
    return self.comercializable.nombreart
  end

  private

  validate :cantidad_val
  validate :factura_impresa
  validate :comercializable_val
  validates_numericality_of :descuento, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :precio_unitario, :message => "El caracter de separacion decimal es .(Punto)."


  before_destroy :factura_val?

  def comercializable_val
    if self.id.nil?
      if !self.comercializable.nil? and !self.factura.nil?
        errors.add(:factura,"Ya existe un renglon con el mismo articulo.") if self.factura.renglon_facturas.where("comercializable_id = ?" , self.comercializable.id.to_s).size() > 0
      end
    else
      if !self.comercializable.nil? and !self.factura.nil?
        errors.add(:factura,"Ya existe un renglon con el mismo articulo.") if self.factura.renglon_facturas.where("comercializable_id = ? and id <> ?" , self.comercializable.id.to_s,self.id.to_s).size() > 0
      end
    end
  end


  def factura_val?
    errors.add(:factura, "No puede modificar una Facura impresa.") if self.factura.impresa?
    errors.blank?
  end

  def cantidad_val
    errors.add(:cantidad,"Debe ingresar una cantidad mayor que cero.") if self.cantidad.nil? || self.cantidad <= 0
  end

  def factura_impresa
    if !self.factura.nil?
      errors.add(:factura,"No puede modificar una Facura impresa.") if self.factura.impresa?
    end
  end

end
