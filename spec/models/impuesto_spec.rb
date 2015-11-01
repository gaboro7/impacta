# == Schema Information
#
# Table name: impuestos
#
#  id          :integer          not null, primary key
#  nombre      :string(255)      not null
#  porcentajea :float            not null
#  porcentajec :float            default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Impuesto do
  pending "add some examples to (or delete) #{__FILE__}"
end
