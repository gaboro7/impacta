# == Schema Information
#
# Table name: renglon_ndcdetalles
#
#  id               :integer          not null, primary key
#  detalle          :string(255)      not null
#  notadecredito_id :integer          not null
#  total_impuestos  :float            not null
#  total_renglon    :float            not null
#  factura_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class RenglonNdcdetalle < ActiveRecord::Base
  belongs_to :notadecredito
  has_many :impuestos_renglon_ndc, :as => :renglon
  has_many :impuestos, :through => :impuestos_renglon_ndc
  has_many :foto_impuesto_ndcs, :as => :renglon, :dependent => :destroy
  belongs_to :factura


  private

  validate :notadecredito_impresa
  validates_numericality_of :total_impuestos, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :total_renglon, :message => "El caracter de separacion decimal es .(Punto)."



  after_update :actualizar_impuestos


  before_destroy :notadecredito_val?


  def notadecredito_val?
    errors.add(:notadecredito, "No puede modificar una Nota de Credito impresa.") if self.notadecredito.impresa?
    errors.blank?
  end


  def actualizar_impuestos
    for im in self.foto_impuesto_ndcs
      im.destroy
    end
    for imp in self.impuestos
      @fi = self.foto_impuesto_ndcs.create(:nombre => imp.nombre, :porcentaje => imp.porcentajea)
      @fi.save
    end

  end


  def notadecredito_impresa
    errors.add(:notadecredito,"No puede modificar una Nota de Credito impresa.") if self.notadecredito.impresa?
  end



end
