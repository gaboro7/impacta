# == Schema Information
#
# Table name: renglon_notadebitos
#
#  id                 :integer          not null, primary key
#  notadedebito_id    :integer          not null
#  factura_id         :integer          not null
#  comentario         :string(255)
#  cantidad           :integer          not null
#  comercializable_id :integer          not null
#  descuento          :float            default(0.0)
#  precio_unitario    :float            not null
#  total_impuestos    :float            not null
#  total_renglon      :float            not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class RenglonNotadebito < ActiveRecord::Base
  belongs_to :notadedebito
  belongs_to :factura
  belongs_to :comercializable

  has_many :foto_impuesto_ndds, :as => :renglon, :dependent => :destroy

  private

  before_destroy :notadedebito_val?


  def  nombrearticulo
    return self.comercializable.nombreart
  end


  validates_numericality_of :total_impuestos, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :total_renglon, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :descuento, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :precio_unitario, :message => "El caracter de separacion decimal es .(Punto)."
  validates :comercializable, :presence => {:message => "Debe seleccionar un Articulo."}
  #validate :factura_articulo_val


  def comerciante_val
    errors.add(:factura, "No puede asignar una factura que no corresponde con el titular de la Nota de Debito.") if self.factura.comerciante != self.notadedebito.comerciante
  end

  #def factura_articulo_val
  #  if !self.factura.nil? and !self.comercializable.nil?
  #    errors.add(:factura,"Ya existe un renglon con el mismo articulo y la misma factura.") if self.notadedebito.renglon_notadebitos.where("comercializable_id = ? and factura_id = ?" , self.comercializable.id.to_s, self.factura.id).size() > 0
  #  end
  #end

  def notadedebito_val?
    errors.add(:notadedebito, "No puede modificar una Nota de Debito impresa.") if self.notadedebito.impresa?
  end


end
