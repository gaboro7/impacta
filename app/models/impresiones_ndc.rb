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

class ImpresionesNdc < ActiveRecord::Base
  belongs_to :notadecredito
end
