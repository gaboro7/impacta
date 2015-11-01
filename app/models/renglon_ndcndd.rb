# == Schema Information
#
# Table name: renglon_ndcndds
#
#  id               :integer          not null, primary key
#  notadecredito_id :integer
#  notadedebito_id  :integer
#  detalle          :string(255)
#  total_renglon    :float
#  total_impuestos  :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class RenglonNdcndd < ActiveRecord::Base
  belongs_to :notadecredito
  belongs_to :notadedebito

  has_many :impuestos_renglon_ndc, :as => :renglon
  has_many :impuestos, :through => :impuestos_renglon_ndc
  has_many :foto_impuesto_ndcs, :as => :renglon, :dependent => :destroy


  private

  validate :notadecredito_impresa
  validates :notadedebito, :presence => { :message => "Debe ingresar una Nota de Debito." }
  validates :total_renglon, :presence => {:message => "Debe ingresar un Importe."}
  validates_numericality_of :total_impuestos, :message => "El caracter de separacion decimal es .(Punto)."

  validates_numericality_of :total_renglon, :message => "El caracter de separacion decimal es .(Punto)."


  before_destroy :notadecredito_val?


  def notadecredito_val?
    errors.add(:notadecredito, "No puede modificar una Nota de Credito impresa.") if self.notadecredito.impresa?
  end


  def notadecredito_impresa
    errors.add(:notadecredito,"No puede modificar una Nota de Credito impresa.") if self.notadecredito.impresa?
  end

   def  nombrearticulo
    return self.comercializable.nombreart
  end



end
