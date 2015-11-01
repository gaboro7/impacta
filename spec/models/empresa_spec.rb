# == Schema Information
#
# Table name: clientes
#
#  id             :integer          not null, primary key
#  type           :string(255)      not null
#  credito        :boolean          default(FALSE)
#  precargo       :float
#  urecargo       :string(255)
#  cantrecargo    :integer
#  pdescuento     :integer          default(0)
#  habilitado     :boolean          default(TRUE)
#  listaprecio_id :integer
#  tipocliente_id :integer
#  domicilio      :string(255)      not null
#  departamento   :string(255)
#  barrio         :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  nombre         :string(255)      not null
#  nic            :string(255)
#  nombrereal     :string(255)
#  nombrefiscal   :string(255)
#  nif            :string(255)
#  dirweb         :string(255)
#

require 'spec_helper'

describe Empresa do
  pending "add some examples to (or delete) #{__FILE__}"
end

