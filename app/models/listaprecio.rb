# == Schema Information
#
# Table name: listaprecios
#
#  id             :integer          not null, primary key
#  nombre         :string(255)      not null
#  predeterminada :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Listaprecio < ActiveRecord::Base
  has_many :clientes
  has_many :precioarts

  private

  validates :nombre, :presence => {:message => "Debe ingresar un Nombre."}, :uniqueness => {:message => "Ya existe una Lista con el mismo Nombre.", :case_sensitive => false}

  validate :predeterminada_val





  def predeterminada_val
    if self.predeterminada? then
      if self.id.nil?
        @listas = Listaprecio.where("predeterminada = 1")
      else
        @listas = Listaprecio.where("id != ? AND predeterminada = 1",self.id)
      end
      errors.add(:predeterminada,"Ya existe una Lista de Precio predeterminada.") if !@listas.empty?
    end
  end


end
