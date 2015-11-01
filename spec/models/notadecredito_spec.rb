# == Schema Information
#
# Table name: notadecreditos
#
#  id                :integer          not null, primary key
#  anulada           :boolean          default(FALSE)
#  es_devolucion     :boolean          default(FALSE)
#  rut               :string(255)      not null
#  direccion_cliente :string(255)      not null
#  codigo_barras     :string(255)
#  comerciante_id    :integer          not null
#  comerciante_type  :string(255)      not null
#  detalle           :string(255)
#  fecha             :date             not null
#  moneda_id         :integer          not null
#  nom_moneda        :string(255)
#  tipo_de_cambio    :float
#  impresa           :boolean          default(FALSE)
#  sucursal_id       :integer
#  numero            :string(255)
#  adeudo            :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Notadecredito do
  pending "add some examples to (or delete) #{__FILE__}"
end
