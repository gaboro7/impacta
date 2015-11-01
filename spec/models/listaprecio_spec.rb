# == Schema Information
#
# Table name: listaprecios
#
#  id             :integer          not null, primary key
#  nombre         :string(255)      not null
#  predeterminada :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Listaprecio do
  pending "add some examples to (or delete) #{__FILE__}"
end
