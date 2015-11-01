# == Schema Information
#
# Table name: articulos_rolarticulos
#
#  rolarticulo_id :integer
#  articulo_id    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ArticulosRolarticulo < ActiveRecord::Base
  belongs_to :rolarticulo
  belongs_to :articulo
end
