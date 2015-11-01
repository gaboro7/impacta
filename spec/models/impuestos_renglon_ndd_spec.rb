# == Schema Information
#
# Table name: impuestos_renglon_ndds
#
#  id           :integer          not null, primary key
#  impuesto_id  :integer
#  renglon_id   :integer
#  renglon_type :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe ImpuestosRenglonNdd do
  pending "add some examples to (or delete) #{__FILE__}"
end
