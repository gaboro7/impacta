# == Schema Information
#
# Table name: precioarts
#
#  id                 :integer          not null, primary key
#  precio             :float            default(0.0)
#  descuento          :float            default(0.0)
#  comercializable_id :integer          not null
#  listaprecio_id     :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe Precioart do
  pending "add some examples to (or delete) #{__FILE__}"
end
