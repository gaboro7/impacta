# == Schema Information
#
# Table name: renglon_recdetalles
#
#  id            :integer          not null, primary key
#  recibo_id     :integer          not null
#  detalle       :string(255)      not null
#  total_renglon :float            not null
#  factura_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class RenglonRecdetalle < ActiveRecord::Base

  belongs_to :recibo
  belongs_to :factura

  private
  validates_numericality_of :total_renglon, :message => "El caracter de separacion decimal es .(Punto)."
  validate :saldo
  before_destroy :recibo_val?

  def recibo_val?
    errors.add(:recibo, "No puede modificar una Recibo impreso.") if self.recibo.impresa?
    errors.blank?
  end

  def saldo
    if !self.factura.nil?
      errors.add(:total_linea,"No puede asignar un importe mayor al adeudado a la Factura " + self.factura.id.to_s + ".") if self.factura.adeudo - (self.total_renglon)*self.recibo.moneda.tipodecambio/self.factura.moneda.tipodecambio < -1
    end
  end

end
