# == Schema Information
#
# Table name: descuento_clientes
#
#  id                 :integer          not null, primary key
#  cliente_id         :integer          not null
#  comercializable_id :integer          not null
#  descuento          :float            not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe DescuentoCliente do
  pending "add some examples to (or delete) #{__FILE__}"
end
