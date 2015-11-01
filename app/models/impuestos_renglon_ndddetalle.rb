# == Schema Information
#
# Table name: impuestos_renglon_ndddetalles
#
#  id                    :integer          not null, primary key
#  impuesto_id           :integer          not null
#  renglon_ndddetalle_id :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class ImpuestosRenglonNdddetalle < ActiveRecord::Base
  belongs_to :impuesto
  belongs_to :renglon_ndddetalle
end
