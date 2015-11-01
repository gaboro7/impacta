# == Schema Information
#
# Table name: sucursals
#
#  id           :integer          not null, primary key
#  nombre       :string(255)      not null
#  domicilio    :string(255)      not null
#  departamento :string(255)
#  barrio       :string(255)
#  empresa_id   :integer          not null
#  observacion  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Sucursal do
  pending "add some examples to (or delete) #{__FILE__}"
end

