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

require 'spec_helper'

describe FotoImpuestoFact do
  pending "add some examples to (or delete) #{__FILE__}"
end
