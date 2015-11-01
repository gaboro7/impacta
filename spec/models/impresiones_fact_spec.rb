# == Schema Information
#
# Table name: impresiones_facts
#
#  id           :integer          not null, primary key
#  numero       :integer          not null
#  serie        :string(255)      not null
#  anulada      :boolean          default(FALSE)
#  cant_paginas :integer          default(1)
#  factura_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe ImpresionesFact do
  pending "add some examples to (or delete) #{__FILE__}"
end
