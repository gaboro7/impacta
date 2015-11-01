# == Schema Information
#
# Table name: renglon_ndcndds
#
#  id               :integer          not null, primary key
#  notadecredito_id :integer
#  notadedebito_id  :integer
#  detalle          :string(255)
#  total_renglon    :float
#  total_impuestos  :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe RenglonNdcndd do
  pending "add some examples to (or delete) #{__FILE__}"
end
