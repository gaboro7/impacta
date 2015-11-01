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

class Domicilio < ActiveRecord::Base
  belongs_to :persona
end
