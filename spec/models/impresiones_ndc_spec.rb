# == Schema Information
#
# Table name: impresiones_ndcs
#
#  id               :integer          not null, primary key
#  anulada          :boolean          default(FALSE)
#  cant_paginas     :integer          default(1)
#  notadecredito_id :integer          not null
#  numero           :integer          not null
#  serie            :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe ImpresionesNdc do
  pending "add some examples to (or delete) #{__FILE__}"
end
