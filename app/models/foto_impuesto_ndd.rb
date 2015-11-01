# == Schema Information
#
# Table name: foto_impuesto_ndds
#
#  id           :integer          not null, primary key
#  renglon_id   :integer          not null
#  renglon_type :string(255)      not null
#  nombre       :string(255)      not null
#  porcentaje   :float            not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class FotoImpuestoNdd < ActiveRecord::Base
  belongs_to :renglon , :polymorphic => true
end
