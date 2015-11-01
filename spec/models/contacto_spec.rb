# == Schema Information
#
# Table name: contactos
#
#  id               :integer          not null, primary key
#  nombre           :string(255)      not null
#  sector           :string(255)
#  interno          :integer
#  comentarios      :text
#  contactable_id   :integer          not null
#  contactable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Contacto do
  pending "add some examples to (or delete) #{__FILE__}"
end

