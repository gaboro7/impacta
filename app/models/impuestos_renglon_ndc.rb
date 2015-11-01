# == Schema Information
#
# Table name: impuestos_renglon_ndcs
#
#  id           :integer          not null, primary key
#  impuesto_id  :integer
#  renglon_id   :integer
#  renglon_type :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ImpuestosRenglonNdc < ActiveRecord::Base
  belongs_to :impuesto
  belongs_to :renglon, :polymorphic => true
end
