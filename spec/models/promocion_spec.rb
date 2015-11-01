# == Schema Information
#
# Table name: promocions
#
#  id          :integer          not null, primary key
#  fechainicio :date             not null
#  fechafin    :date             not null
#  descuento   :float            default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  descripcion :string(255)
#

require 'spec_helper'

describe Promocion do
  pending "add some examples to (or delete) #{__FILE__}"
end
