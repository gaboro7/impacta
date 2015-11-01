# == Schema Information
#
# Table name: impuestos_renglon_factdetalles
#
#  impuesto_id            :integer          not null
#  renglon_factdetalle_id :integer          not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class ImpuestosRenglonFactdetalle < ActiveRecord::Base
  belongs_to :impuesto
  belongs_to :renglon_factdetalle
end
