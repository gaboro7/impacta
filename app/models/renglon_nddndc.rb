# == Schema Information
#
# Table name: renglon_nddndcs
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

class RenglonNddndc < ActiveRecord::Base
  belongs_to :notadecredito
  belongs_to :notadedebito

  has_many :impuestos_renglon_ndd, :as => :renglon
  has_many :impuestos, :through => :impuestos_renglon_ndd
  has_many :foto_impuesto_ndds, :as => :renglon, :dependent => :destroy


  private

  validate :notadedebito_impresa
  validates :notadecredito, :presence => {:menssage => "Debe ingresar una Nota de Credito."}
  validates :total_renglon, :presence => {:menssage => "Debe ingresar un Importe."}
  validates_numericality_of :total_impuestos, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :total_renglon, :message => "El caracter de separacion decimal es .(Punto)."

  before_destroy :notadedebito_val?


  def notadedebito_val?
    errors.add(:notadedebito, "No puede modificar una Nota de Debito impresa.") if self.notadedebito.impresa?
    errors.blank?
  end


  def notadedebito_impresa
    errors.add(:notadedebito,"No puede modificar una Nota de Debito impresa.") if self.notadedebito.impresa?
  end

end
