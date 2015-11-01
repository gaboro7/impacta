# == Schema Information
#
# Table name: celularcons
#
#  id         :integer          not null, primary key
#  cellular   :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Celularcon < ActiveRecord::Base
  validates :cellular, :presence => {:message => "Debe ingresar un numero de Celular."}, :length => {:minimum => 9,:maximum => 9, :message => "El numero de Celular no tiene 9 digitos."}
end
