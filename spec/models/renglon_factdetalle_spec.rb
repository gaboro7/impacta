# == Schema Information
#
# Table name: renglon_factdetalles
#
#  id              :integer          not null, primary key
#  factura_id      :integer          not null
#  detalle         :string(255)      not null
#  total_renglon   :float            not null
#  total_impuestos :float            not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe RenglonFactdetalle do
  pending "add some examples to (or delete) #{__FILE__}"
end
