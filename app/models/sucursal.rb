# == Schema Information
#
# Table name: sucursals
#
#  id           :integer          not null, primary key
#  nombre       :string(255)      not null
#  domicilio    :string(255)      not null
#  departamento :string(255)
#  barrio       :string(255)
#  empresa_id   :integer          not null
#  observacion  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sucursal < ActiveRecord::Base

  belongs_to :empresa
  has_many :telefonos, :as => :contelefono, :dependent => :destroy
  has_many :contactos, :as => :contactable, :dependent => :destroy
  has_many :mail_internos, :as => :conmail, :dependent => :destroy
  has_many :facturas

  private

  validates :nombre, :presence => {:message => "Debe ingresar el nombre de la Sucursal."}
  validates :domicilio, :presence => {:message => "Debe ingresar el domicilio de la Sucursal."}
  validate :nombre_unico
  before_destroy :tiene_docs

  def tiene_docs
    errors.add(:facturas, "La sucursal tiene facturas asociadas por lo que no puede eliminarse. ") if !self.facturas.empty?
    errors.blank?
  end


  def nombre_unico
    errors.add(:nombre,"Ya existe una Sucursal con ese mismo nombre." ) if self.empresa.sucursals.where(:nombre => self.nombre).size > 1
  end

end

