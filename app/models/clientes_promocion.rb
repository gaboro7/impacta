# == Schema Information
#
# Table name: clientes_promocions
#
#  id           :integer          not null, primary key
#  cliente_id   :integer          not null
#  promocion_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ClientesPromocion < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :promocion
end
