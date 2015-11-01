# == Schema Information
#
# Table name: impuestos_renglon_ndcdetalles
#
#  id                    :integer          not null, primary key
#  impuesto_id           :integer          not null
#  renglon_ndcdetalle_id :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class ImpuestosRenglonNdcdetalle < ActiveRecord::Base
  belongs_to :impuesto
  belongs_to :renglon_ndcdetalle
end
