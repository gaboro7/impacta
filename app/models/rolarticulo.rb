# == Schema Information
#
# Table name: rolarticulos
#
#  id         :integer          not null, primary key
#  type       :string(255)      not null
#  rola_id    :integer          not null
#  rola_type  :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  descuento  :float            default(0.0)
#  garantia   :integer          default(0)
#

class Rolarticulo < ActiveRecord::Base
  belongs_to :rola, :polymorphic => true


  def nombreart
    rola.nombre
  end

end

