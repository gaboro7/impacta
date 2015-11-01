# == Schema Information
#
# Table name: renglon_factdetalles
#
#  id              :integer          not null, primary key
#  factura_id      :integer          not null
#  detalle         :string(255)      not null
#  total_renglon   :float            not null
#  total_impuestos :float            not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class RenglonFactdetalle < ActiveRecord::Base

  belongs_to :factura

  has_many :impuestos_renglon_factdetalle
  has_many :impuestos, :through => :impuestos_renglon_factdetalle
  has_many :foto_impuesto_facts, :as => :renglon, :dependent => :destroy

  private

  validate :factura_impresa
  validates_numericality_of :total_impuestos, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :total_renglon, :message => "El caracter de separacion decimal es .(Punto)."


  before_destroy :factura_val?

  def factura_val?
    errors.add(:factura, "No puede modificar una Facura impresa.") if self.factura.impresa?
    errors.blank?
  end

  def factura_impresa
    errors.add(:factura,"No puede modificar una Facura impresa.") if self.factura.impresa?
  end

end
