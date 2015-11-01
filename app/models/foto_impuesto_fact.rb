# == Schema Information
#
# Table name: foto_impuesto_facts
#
#  id           :integer          not null, primary key
#  nombre       :string(255)      not null
#  porcentaje   :float            not null
#  renglon_id   :integer          not null
#  renglon_type :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class FotoImpuestoFact < ActiveRecord::Base
  belongs_to :renglon , :polymorphic => true

  private

  validates_numericality_of :porcentaje, :message => "El caracter de separacion decimal no es un .(Punto)."

end
