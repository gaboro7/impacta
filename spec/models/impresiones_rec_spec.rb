# == Schema Information
#
# Table name: impresiones_recs
#
#  id           :integer          not null, primary key
#  numero       :integer          not null
#  serie        :string(255)      not null
#  anulada      :boolean          default(FALSE)
#  cant_paginas :integer          default(1)
#  recibo_id    :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe ImpresionesRec do
  pending "add some examples to (or delete) #{__FILE__}"
end
