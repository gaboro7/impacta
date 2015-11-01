# == Schema Information
#
# Table name: descuento_clientes
#
#  id                 :integer          not null, primary key
#  cliente_id         :integer          not null
#  comercializable_id :integer          not null
#  descuento          :float            not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class DescuentoCliente < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :comercializable

  private

  validates :cliente, :presence => {:message => "Debe ingresar un cliente."}
  validates :comercializable, :presence => {:message => "Debe ingresar un comercializable."}
  validate :comercializable_val

def comercializable_val

    if !self.comercializable.nil?
      errors.add(:factura,"Ya existe un renglon con el articulo" + self.comercializable.nombreart+".") if self.cliente.descuento_clientes.where("comercializable_id = ?" , self.comercializable.id.to_s).size() > 1
    end
end




end
