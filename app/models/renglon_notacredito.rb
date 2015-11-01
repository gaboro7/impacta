# == Schema Information
#
# Table name: renglon_notacreditos
#
#  id                 :integer          not null, primary key
#  notadecredito_id   :integer          not null
#  factura_id         :integer          not null
#  comentario         :string(255)
#  cantidad           :integer          not null
#  comercializable_id :integer
#  descuento          :float            default(0.0)
#  precio_unitario    :float            not null
#  total_impuestos    :float            not null
#  total_renglon      :float            not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class RenglonNotacredito < ActiveRecord::Base
  belongs_to :notadecredito
  belongs_to :factura
  belongs_to :comercializable

  has_many :foto_impuesto_ndcs, :as => :renglon, :dependent => :destroy

  def  nombrearticulo
    return self.comercializable.nombreart
  end

   def  numero
    return self.factura.numero
  end

  private

  validate :saldo_factura
  validate :cantArticulos_val
  validate :factura_articulo_val
  validate :comerciante_val
  validates_numericality_of :total_impuestos, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :total_renglon, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :descuento, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :precio_unitario, :message => "El caracter de separacion decimal es .(Punto)."
  validates :comercializable, :presence => { :message => "Debe seleccionar un Articulo." }

  before_destroy :notadecredito_val?

 

  def comerciante_val
    errors.add(:factura, "No puede asignar una factura que no corresponde con el titular de la Nota de Credito") if self.factura.comerciante != self.notadecredito.comerciante
  end

  def factura_articulo_val
    if !self.factura.nil? and !self.comercializable.nil?
      errors.add(:factura,"Ya existe un renglon con el mismo articulo y la misma factura.") if self.notadecredito.renglon_notacreditos.where("comercializable_id = ? and factura_id = ?" , self.comercializable.id.to_s, self.factura.id).size() > 0
    end
  end

 

  def notadecredito_val?
    errors.add(:notadecredito, "No puede modificar una Nota de Credito impresa.") if self.notadecredito.impresa?
    errors.blank?
  end



  def cantArticulos_val
    if !self.comercializable.nil?
     errors.add(:factura, "No puede superar la cantidad de articulos facturados.") if self.factura.renglon_facturas.where(:comercializable_id => self.comercializable.id).sum(:cantidad) < self.cantidad
    end
  end

  def saldo_factura
    if self.factura.nil?
      errors.add(:factura, "Debe ingresar la Factura.") if true
    else
      if self.factura.contado
        errors.add(:factura, "Ha superado el importe de la Factura.") if self.factura.total < (self.total_renglon + self.total_impuestos)*self.notadecredito.moneda.tipodecambio/self.factura.moneda.tipodecambio
      else
        errors.add(:factura, "Ha superado el adeudo de la Factura.") if self.factura.adeudo < (self.total_renglon + self.total_impuestos)*self.notadecredito.moneda.tipodecambio/self.factura.moneda.tipodecambio
      end
    end
  end
end
