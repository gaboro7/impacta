# == Schema Information
#
# Table name: impuestos
#
#  id          :integer          not null, primary key
#  nombre      :string(255)      not null
#  porcentajea :float            not null
#  porcentajec :float            default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'enumerated_attribute'

class Impuesto < ActiveRecord::Base
  enum_attr :estado, %w(habilitado, deshabilitado)
  has_many :comercializable


  private

  validates :nombre, :presence => {:message => "Debe ingresar un Nombre."}, :uniqueness => {:message => "Ya existe un Impusto con el mismo Nombre.", :case_sensitive => false}
  validates_numericality_of :porcentajea, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :porcentajec, :message => "El caracter de separacion decimal es .(Punto)."
  validate :porcentajea_val

  def porcentajea_val
    if !self.porcentajea.nil?
      errors.add(:porcentajea,"El porcentaje de impuesto debe ser positivo.") if self.porcentajea < 0
      errors.add(:porcentajea,"El porcentaje de impuesto no puede ser superior a 100.") if self.porcentajea > 100
    else
      self.porcentajea = 0
      self.save
    end
  end
end
