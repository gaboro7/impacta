# == Schema Information
#
# Table name: formadepagos
#
#  id             :integer          not null, primary key
#  nombre         :string(255)      not null
#  estado         :string(255)      not null
#  predeterminada :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  cantidad       :integer
#  type           :string(255)      not null
#  unidad         :string(255)
#

require 'spec_helper'

describe Formadepago do
  pending "add some examples to (or delete) #{__FILE__}"
end



