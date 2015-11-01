# == Schema Information
#
# Table name: foto_impuesto_recs
#
#  id                    :integer          not null, primary key
#  nombre                :string(255)      not null
#  porcentaje            :float            not null
#  renglon_recdetalle_id :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'spec_helper'

describe FotoImpuestoRec do
  pending "add some examples to (or delete) #{__FILE__}"
end
