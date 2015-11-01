# == Schema Information
#
# Table name: renglon_ndddetalles
#
#  id              :integer          not null, primary key
#  detalle         :string(255)      not null
#  notadedebito_id :integer          not null
#  total_impuestos :float            not null
#  total_renglon   :float            not null
#  factura_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe RenglonNdddetalle do
  pending "add some examples to (or delete) #{__FILE__}"
end
