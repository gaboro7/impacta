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

class FotoImpuestoRec < ActiveRecord::Base
  belongs_to :renglon_recdetalle
end
