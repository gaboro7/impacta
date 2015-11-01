# == Schema Information
#
# Table name: rolarticulos
#
#  id         :integer          not null, primary key
#  type       :string(255)      not null
#  rola_id    :integer          not null
#  rola_type  :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  descuento  :float            default(0.0)
#  garantia   :integer          default(0)
#

require 'spec_helper'

describe Rolarticulo do
  pending "add some examples to (or delete) #{__FILE__}"
end

