# == Schema Information
#
# Table name: renglon_recdetalles
#
#  id            :integer          not null, primary key
#  recibo_id     :integer          not null
#  detalle       :string(255)      not null
#  total_renglon :float            not null
#  factura_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe RenglonRecdetalle do
  pending "add some examples to (or delete) #{__FILE__}"
end
