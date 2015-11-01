# == Schema Information
#
# Table name: monedas
#
#  id             :integer          not null, primary key
#  nombre         :string(255)      not null
#  tipodecambio   :float            default(0.0)
#  predeterminada :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Moneda do
  pending "add some examples to (or delete) #{__FILE__}"
end

