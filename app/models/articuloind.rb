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

class Articuloind < Articulo


  private

  after_create :crearcomercializable

  
  def crearcomercializable
    @com = Comercializable.new(:descuento => 0,:garantia => 0)
    self.rolarticulos << @com
    self.save
  end
  
  def validate_rol    
    errors.add(:rolarticulos, "debe agregar por lo menos un tipo al articulo") if rolarticulos.size > 1
  end
  

end

