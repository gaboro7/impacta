# == Schema Information
#
# Table name: telefonos
#
#  id               :integer          not null, primary key
#  telefono         :string(255)
#  contelefono_id   :integer          not null
#  contelefono_type :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Telefono do
  pending "add some examples to (or delete) #{__FILE__}"
end
