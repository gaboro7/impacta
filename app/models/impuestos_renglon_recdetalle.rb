# == Schema Information
#
# Table name: impuestos_renglon_recdetalles
#
#  impuesto_id           :integer          not null
#  renglon_recdetalle_id :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class ImpuestosRenglonRecdetalle < ActiveRecord::Base
  belongs_to :impuesto
  belongs_to :renglon_recdetalle
end
