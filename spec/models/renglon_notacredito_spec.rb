# == Schema Information
#
# Table name: renglon_notacreditos
#
#  id                 :integer          not null, primary key
#  notadecredito_id   :integer          not null
#  factura_id         :integer          not null
#  comentario         :string(255)
#  cantidad           :integer          not null
#  comercializable_id :integer
#  descuento          :float            default(0.0)
#  precio_unitario    :float            not null
#  total_impuestos    :float            not null
#  total_renglon      :float            not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe RenglonNotacredito do
  pending "add some examples to (or delete) #{__FILE__}"
end
