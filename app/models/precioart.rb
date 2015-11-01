# == Schema Information
#
# Table name: precioarts
#
#  id                 :integer          not null, primary key
#  precio             :float            default(0.0)
#  descuento          :float            default(0.0)
#  comercializable_id :integer          not null
#  listaprecio_id     :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#


class Precioart < ActiveRecord::Base

  belongs_to :comercializable
  belongs_to :listaprecio

  private


  validate :comercializable_val
  validates :comercializable_id, :presence => {:message => "Debe seleccionar un Articulo."}
  validates_numericality_of :descuento, :message => "El caracter de separacion decimal es .(Punto)."
  validates_numericality_of :precio, :message => "El caracter de separacion decimal es .(Punto)."


  def comercializable_val
    if self.comercializable
      for pr in self.listaprecio.precioarts
        errors.add(:comercializable,"Ya existe el articulo en la lista") if pr.comercializable.id == self.comercializable.id  and self.id != pr.id
      end
    end
  end

end
