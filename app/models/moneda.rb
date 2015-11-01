# == Schema Information
#
# Table name: monedas
#
#  id             :integer          not null, primary key
#  nombre         :string(255)      not null
#  tipodecambio   :float            default(0.0)
#  predeterminada :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Moneda < ActiveRecord::Base

  has_many :formadepago, :through => :formadepagos_moneda

  private


  validates :nombre, :uniqueness => {:message => "Ya existe una moneda con este nombre.", :case_sensitive => false}, :presence => {:message => "Debe ingresar un Nombre."}
  validates_numericality_of :tipodecambio, :message => "El caracter de separacion decimal es .(Punto)."
  before_save :tipodecambio_val

  validate :predeterminada_val





  def predeterminada_val
    if self.predeterminada? then
      if self.id.nil?
        @monedas = Moneda.where("predeterminada = 1")
      else
        @monedas = Moneda.where("id != ? AND predeterminada = 1",self.id)
      end
      errors.add(:predeterminada,"Ya existe una moneda predeterminada.") if !@monedas.empty?
    end
  end

  def tipodecambio_val
    if self.predeterminada?
      self.tipodecambio = 1
    elsif self.tipodecambio.nil?
      self.tipodecambio = 1
    end

  end

end

