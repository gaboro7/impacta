# == Schema Information
#
# Table name: domicilios
#
#  id         :integer          not null, primary key
#  domicilio  :string(255)
#  persona_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Domicilio do
  pending "add some examples to (or delete) #{__FILE__}"
end
