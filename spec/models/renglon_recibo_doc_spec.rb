# == Schema Information
#
# Table name: renglon_recibo_docs
#
#  id             :integer          not null, primary key
#  recibo_id      :integer          not null
#  documento_id   :integer          not null
#  documento_type :string(255)      not null
#  total_renglon  :float            not null
#  detalle        :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe RenglonReciboDoc do
  pending "add some examples to (or delete) #{__FILE__}"
end
