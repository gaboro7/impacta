# == Schema Information
#
# Table name: impresiones_facts
#
#  id           :integer          not null, primary key
#  numero       :integer          not null
#  serie        :string(255)      not null
#  anulada      :boolean          default(FALSE)
#  cant_paginas :integer          default(1)
#  factura_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ImpresionesFact < ActiveRecord::Base
  belongs_to :factura

  private

  validates :numero, :numericality => {:message => "Debe ingresar un numero valido."}

  #validate :numero_val

  #def numero_val
  #  self.factura.errors.add(:numero, "Ya existe una impresion con ese numero") if ImpresionesFact.where(:numero => self.numero) > 1
  #end



end
