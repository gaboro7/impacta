# == Schema Information
#
# Table name: articulos_articulocomps
#
#  id              :integer          not null, primary key
#  articulo_id     :integer
#  articulocomp_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ArticulosArticulocomp < ActiveRecord::Base
  belongs_to :articulo
  belongs_to :articulocomp
end
