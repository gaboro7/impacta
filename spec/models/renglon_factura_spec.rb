# == Schema Information
#
# Table name: renglon_facturas
#
#  id                 :integer          not null, primary key
#  factura_id         :integer          not null
#  total_renglon      :float            not null
#  total_impuestos    :float            not null
#  comercializable_id :integer          not null
#  cantidad           :integer          not null
#  precio_unitario    :float            not null
#  descuento          :float            default(0.0)
#  comentario         :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe RenglonFactura do
  pending "add some examples to (or delete) #{__FILE__}"
end
