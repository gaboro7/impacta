# == Schema Information
#
# Table name: comercializables_promocions
#
#  comercializable_id :integer
#  promocion_id       :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ComercializablesPromocion < ActiveRecord::Base
  belongs_to :comercializable
  belongs_to :promocion


end

