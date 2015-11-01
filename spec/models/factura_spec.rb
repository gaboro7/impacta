# == Schema Information
#
# Table name: facturas
#
#  id                :integer          not null, primary key
#  rut               :string(255)      not null
#  direccion_cliente :string(255)      not null
#  contado           :boolean          not null
#  detalle           :string(255)
#  fecha             :date             not null
#  codigo_barras     :string(255)
#  comerciante_id    :integer          not null
#  comerciante_type  :string(255)      not null
#  sucursal_id       :integer
#  formadepago_id    :integer
#  moneda_id         :integer          not null
#  nom_moneda        :string(255)
#  tipo_de_cambio    :float
#  impresa           :boolean          default(FALSE)
#  anulada           :boolean          default(FALSE)
#  adeudo            :float            default(0.0)
#  numero            :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Factura do
  pending "add some examples to (or delete) #{__FILE__}"
end
