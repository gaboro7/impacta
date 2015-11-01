# == Schema Information
#
# Table name: foto_impuesto_ndds
#
#  id           :integer          not null, primary key
#  renglon_id   :integer          not null
#  renglon_type :string(255)      not null
#  nombre       :string(255)      not null
#  porcentaje   :float            not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe FotoImpuestoNdd do
  pending "add some examples to (or delete) #{__FILE__}"
end
