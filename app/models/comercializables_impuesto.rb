# == Schema Information
#
# Table name: comercializables_impuestos
#
#  comercializable_id   :integer
#  comercializable_type :string(255)      default("Rolarticulo")
#  impuesto_id          :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class ComercializablesImpuesto < ActiveRecord::Base
  belongs_to :comercializable
  belongs_to :impuesto
end
