# == Schema Information
#
# Table name: renglon_recibos
#
#  id            :integer          not null, primary key
#  factura_id    :integer          not null
#  recibo_id     :integer          not null
#  total_renglon :float            not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class RenglonRecibo < ActiveRecord::Base
  belongs_to :factura
  belongs_to :recibo

  private

  validates :factura, :presence => {:menssage => "Debe ingresar una Factura."}
  validate :factura_impresa
  validates :total_renglon, :presence => {:menssage => "Debe ingresar un Importe."}
  validate :saldo
  validate :factura_val

  validates_numericality_of :total_renglon, :message => "El caracter de separacion decimal es .(Punto)."

  before_destroy :recibo_val?


  def factura_val

    if !self.factura.nil?
      if !self.id.nil?
        errors.add(:factura,"Ya existe un renglon con la misma factura.") if self.recibo.renglon_recibos.where("factura_id = ? and id <> ?" , self.factura.id.to_s, self.id.to_s).size() > 0
      else
        errors.add(:factura,"Ya existe un renglon con la misma factura.") if self.recibo.renglon_recibos.where("factura_id = ? " , self.factura.id.to_s).size() > 0
      end
    end

  end

  def recibo_val?
    errors.add(:recibo, "No puede modificar un Recibo impreso.") if self.recibo.impresa?
    errors.blank?
  end

  def saldo
    errors.add(:total_linea,"No puede asignar un importe mayor al adeudado a la Factura " + self.factura.id.to_s + ".") if self.factura.adeudo - (self.total_renglon )*self.recibo.moneda.tipodecambio/self.factura.moneda.tipodecambio < -1
  end

  def factura_impresa
    errors.add(:factura,"No puede asignar una factura que no fue Impresa.") if !self.factura.impresa?
  end
end
