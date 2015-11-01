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

class Articulocomp < Articulo

  has_many :articulos_articulocomps, :dependent => :destroy
  has_many :articulos, :through => :articulos_articulocomps
  
  
  
  after_create :crearcomercializable
  
  private
  
  def crearcomercializable
    @com = Comercializable.new(:descuento => 0,:garantia => 0)
    self.rolarticulos << @com
    self.save
  end
  
end

