# == Schema Information
#
# Table name: formadepagos_promocions
#
#  formadepago_id :integer
#  promocion_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class FormadepagosPromocion < ActiveRecord::Base
  belongs_to :formadepago
  belongs_to :promocion
end
