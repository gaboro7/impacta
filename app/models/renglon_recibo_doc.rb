# == Schema Information
#
# Table name: renglon_recibo_docs
#
#  id             :integer          not null, primary key
#  recibo_id      :integer          not null
#  documento_id   :integer          not null
#  documento_type :string(255)      not null
#  total_renglon  :float            not null
#  detalle        :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class RenglonReciboDoc < ActiveRecord::Base
  belongs_to :recibo
  belongs_to :documento, :polymorphic => true

  #attr_accessible :detalle, :documento_id, :documento_type, :total_impuestos, :total_renglon

  private


  validates :total_renglon, :presence => {:menssage => "Debe ingresar un Importe."}
  validate :saldo
  validate :documento_val
  validate :documento_impreso


  validates_numericality_of :total_renglon, :message => "El caracter de separacion decimal es .(Punto)."

  before_destroy :recibo_val?


  def documento_val

    if !self.documento.nil?
      if !self.id.nil?
        errors.add(:documento,"Ya existe un renglon con el mismo documento.") if self.recibo.renglon_recibo_docs.where("documento_id = ? and documento_type = ? and id <> ?" , self.documento.id.to_s, self.documento.class.name, self.id.to_s).size() > 0
      else
        errors.add(:documento,"Ya existe un renglon con el mismo documento.") if self.recibo.renglon_recibo_docs.where("documento_id = ? and documento_type = ? and id <> ?" , self.documento.id.to_s, self.documento.class.name, self.id.to_s).size() > 0
      end
    end

  end

  def recibo_val?
    errors.add(:recibo, "No puede modificar un Recibo impreso.") if self.recibo.impresa?
    errors.blank?
  end

  def saldo
    if !self.documento.nil?
      if self.documento.class.name == "Factura" || self.documento.class.name == "Notadedebito"
        errors.add(:total_linea,"No puede asignar un importe mayor al pendiente de la " + self.documento.class.name.to_s + " " + self.documento.id.to_s + ".") if self.documento.adeudo - (self.total_renglon )*self.recibo.moneda.tipodecambio/self.documento.moneda.tipodecambio < -1
      else
        errors.add(:total_linea,"No puede asignar un importe mayor al pendiente de la " + self.documento.class.name.to_s + " " + self.documento.id.to_s + ".") if self.documento.adeudo - (self.total_renglon )*self.recibo.moneda.tipodecambio/self.documento.moneda.tipodecambio > 1
      end
    end
  end

  def documento_impreso
    errors.add(:documento,"No puede asignar un documento que no fue Impresa.") if !self.documento.impresa?
  end

end
