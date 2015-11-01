# == Schema Information
#
# Table name: renglon_ndd_articulos
#
#  id                 :integer          not null, primary key
#  notadedebito_id    :integer          not null
#  comercializable_id :integer          not null
#  cantidad           :integer          not null
#  precio_unitario    :float            not null
#  total_renglon      :float            not null
#  total_impuestos    :float            not null
#  descuento          :float            default(0.0)
#  comentario         :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class RenglonNddArticulo < ActiveRecord::Base
  belongs_to :comercializable
  attr_accessible :cantidad, :comentario, :descuento, :precio, :total_impuestos, :total_renglon
end
