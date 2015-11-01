# == Schema Information
#
# Table name: formadepagos_monedas
#
#  formadepago_id :integer          not null
#  moneda_id      :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class FormadepagosMoneda < ActiveRecord::Base
  belongs_to :formadepago
  belongs_to :moneda
end
