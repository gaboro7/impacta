# == Schema Information
#
# Table name: recibos
#
#  id                :integer          not null, primary key
#  fecha             :date             not null
#  codigo_barras     :string(255)
#  detalle           :string(255)
#  rut               :string(255)      not null
#  direccion_cliente :string(255)      not null
#  pagocontado_id    :integer          not null
#  comerciante_id    :integer          not null
#  comerciante_type  :string(255)      not null
#  sucursal_id       :integer
#  moneda_id         :integer          not null
#  nom_moneda        :string(255)
#  tipo_de_cambio    :float
#  impresa           :boolean          default(FALSE)
#  anulada           :boolean          default(FALSE)
#  numero            :string(255)
#  manual            :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Recibo do
  pending "add some examples to (or delete) #{__FILE__}"
end
