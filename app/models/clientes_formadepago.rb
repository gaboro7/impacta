# == Schema Information
#
# Table name: clientes_formadepagos
#
#  cliente_id     :integer
#  formadepago_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ClientesFormadepago < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :formadepago
end
