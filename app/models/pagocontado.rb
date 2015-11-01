# == Schema Information
#
# Table name: formadepagos
#
#  id             :integer          not null, primary key
#  nombre         :string(255)      not null
#  estado         :string(255)      not null
#  predeterminada :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  cantidad       :integer
#  type           :string(255)      not null
#  unidad         :string(255)
#

require 'enumerated_attribute'

class Pagocontado < Formadepago


  private

  validate :predeterminada_val



  def predeterminada_val
    if self.predeterminada? then
      if self.id.nil?
        @pc = Pagocontado.where("predeterminada = '1'")
      else
        @pc = Pagocontado.where("id <> ? AND predeterminada = '1'",self.id)
      end

      errors.add(:predeterminada,"Ya existe un Pago contado como predeterminado.") if !@pc.empty?
    end
  end

end


