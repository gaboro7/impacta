# == Schema Information
#
# Table name: formadepagos
#
#  id             :integer          not null, primary key
#  nombre         :string(255)      not null
#  estado         :string(255)      not null
#  predeterminada :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  cantidad       :integer
#  type           :string(255)      not null
#  unidad         :string(255)
#

require 'enumerated_attribute'

class Formadepago < ActiveRecord::Base
  enum_attr :estado, %w(habilitado deshabilitado)
  has_many :formadepagos_moneda
  has_many :moneda, :through => :formadepagos_moneda



  has_many :clientes_formadepago
  has_many :cliente, :through => :clientes_formadepago

  has_many :formadepagos_promocion
  has_many :promocion, :through => :formadepagos_promocion


  private

  validates :nombre, :presence => {:message => "Debe ingresar un Nombre."}, :uniqueness => {:message => "Ya existe una Forma de Pago con el mismo Nombre. ", :case_sensitive => false}
  validate :predeterminada_estado

  before_save :estado_val

  before_destroy :referencias_promociones?

  def referencias_promociones?
    errors.add(:promocion,"No puede eliminar la Forma de Pago, tiene Promociones asociadas.") if !self.promocion.empty?
    errors.blank?
  end


  def predeterminada_estado
    errors.add(:predeterminada,"No puedes asignar como predeterminada si esta deshabilitado") if (self.predeterminada? and self.estado == :deshabilitado)
  end

  def estado_val
    if self.estado.nil?
      self.estado = "habilitado"
    end
  end


end





