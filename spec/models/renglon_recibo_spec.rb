# == Schema Information
#
# Table name: renglon_recibos
#
#  id            :integer          not null, primary key
#  factura_id    :integer          not null
#  recibo_id     :integer          not null
#  total_renglon :float            not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe RenglonRecibo do
  pending "add some examples to (or delete) #{__FILE__}"
end
