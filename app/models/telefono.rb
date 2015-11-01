# == Schema Information
#
# Table name: telefonos
#
#  id               :integer          not null, primary key
#  telefono         :string(255)
#  contelefono_id   :integer          not null
#  contelefono_type :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Telefono < ActiveRecord::Base
  belongs_to :contelefono, :polymorphic => true

  private

  validates :telefono, :presence => {:message => "Debe agregar un numero de telefono"},:length => {:minimum => 8, :maximum => 14, :message => "Debe tener por lo menos 8 digitos y no mas de 14."}
end
