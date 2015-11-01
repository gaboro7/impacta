# == Schema Information
#
# Table name: articulos
#
#  id          :integer          not null, primary key
#  type        :string(255)      not null
#  nombre      :string(255)      not null
#  descripcion :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'enumerated_attribute'

class Articulo < ActiveRecord::Base
  enum_attr :estado, %w(habilitado, deshabilitado)
  has_many :rolarticulos, :as => :rola, :limit => 2, :dependent => :destroy



  private

  validates :nombre, :presence => {:message => "Debe ingresar un Nombre al Articulo."}, :uniqueness => {:message => "Ya existe un Articulo con el mismo Nombre.", :case_sensitive => false}


end

