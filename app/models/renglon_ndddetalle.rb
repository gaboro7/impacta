# == Schema Information
#
# Table name: renglon_ndddetalles
#
#  id              :integer          not null, primary key
#  detalle         :string(255)      not null
#  notadedebito_id :integer          not null
#  total_impuestos :float            not null
#  total_renglon   :float            not null
#  factura_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class RenglonNdddetalle < ActiveRecord::Base
  belongs_to :notadedebito
  belongs_to :factura
  has_many :impuestos_renglon_ndd, :as => :renglon
  has_many :impuestos, :through => :impuestos_renglon_ndd
  has_many :foto_impuesto_ndds, :as => :renglon, :dependent => :destroy


  private

  validate :notadedebito_impresa
  validates_numericality_of :total_impuestos, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :total_renglon, :message => "El caracter de separacion decimal es .(Punto)."



  after_update :actualizar_impuestos

  before_destroy :notadedebito_val?


  def notadedebito_val?
    errors.add(:notadedebito, "No puede modificar una Nota de Debito impresa.") if self.notadedebito.impresa?
    errors.blank?
  end

  def actualizar_impuestos
    for im in self.foto_impuesto_ndds
      im.destroy
    end
    for imp in self.impuestos
      @fi = self.foto_impuesto_ndds.create(:nombre => imp.nombre, :porcentaje => imp.porcentajea)
      @fi.save
    end

  end


  def notadedebito_impresa
    errors.add(:notadedebito,"No puede modificar una Nota de Debito impresa.") if self.notadedebito.impresa?
  end

end
