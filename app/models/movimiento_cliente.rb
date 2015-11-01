# == Schema Information
#
# Table name: movimiento_clientes
#
#  id             :integer          not null, primary key
#  documento_id   :integer
#  documento_type :string(255)
#  cliente_id     :integer          not null
#  sucursal_id    :integer
#  operacion      :string(255)      not null
#  fecha          :date             not null
#  debe           :float            not null
#  haber          :float            not null
#  saldo          :float            not null
#  moneda_id      :integer          not null
#  debe_sucursal  :float
#  haber_sucursal :float
#  saldo_sucursal :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class MovimientoCliente < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :documento, :polymorphic => true
  belongs_to :sucursal
  belongs_to :moneda

end
