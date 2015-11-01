require 'enumerated_attribute'

class Pagoacredito < Formadepago
    enum_attr :unidad, %w(dia mes anio), :presence => {:message => "Debe ingresar una unidad."}

    private

    validates :cantidad, :presence => {:message => "Debe ingresar una cantidad."}
    validates :unidad, :presence => {:message => "Debe ingresar una unidad."}
    validate :predeterminada_val



  def predeterminada_val
    if self.predeterminada? then
      if self.id.nil?
        @pc = Pagoacredito.where("predeterminada = '1'")
      else
         @pc = Pagoacredito.where("id <> ? AND predeterminada = '1'",self.id)
      end
      errors.add(:predeterminada,"Ya existe un Pago a credito como predeterminado.") if !@pc.empty?
    end
  end

end

# == Schema Information
#
# Table name: formadepagos
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  utilizada  :boolean
#  created_at :datetime
#  updated_at :datetime
#

