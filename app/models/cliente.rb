# == Schema Information
#
# Table name: clientes
#
#  id             :integer          not null, primary key
#  type           :string(255)      not null
#  credito        :boolean          default(FALSE)
#  precargo       :float
#  urecargo       :string(255)
#  cantrecargo    :integer
#  pdescuento     :integer          default(0)
#  habilitado     :boolean          default(TRUE)
#  listaprecio_id :integer
#  tipocliente_id :integer
#  domicilio      :string(255)      not null
#  departamento   :string(255)
#  barrio         :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  nombre         :string(255)      not null
#  nic            :string(255)
#  nombrereal     :string(255)
#  nombrefiscal   :string(255)
#  nif            :string(255)
#  dirweb         :string(255)
#

require 'enumerated_attribute'

class Cliente < ActiveRecord::Base
  default_scope :order => "nombre ASC"

	enum_attr :urecargo, %w(dia mes anio)
	belongs_to :tipocliente
  has_many :telefonos, :as => :contelefono, :dependent => :destroy
  has_many :mail_internos, :as => :conmail, :dependent => :destroy
  has_many :clientes_formadepago
  has_many :formadepago, :through => :clientes_formadepago
  belongs_to :listaprecio  
  has_many :facturas, :as => :comerciante
  has_many :recibos, :as => :comerciante
  has_many :notadecreditos, :as => :comerciante
  has_many :notadedebitos, :as => :comerciante
  has_many :movimientos, :class_name => "MovimientoCliente"
  has_many :clientes_promocion
  has_many :promocion, :through => :clientes_promocion
  has_many :descuento_clientes


  private


  validates_numericality_of :pdescuento, :message => "El caracter de separacion decimal es .(Punto)."
  validates :domicilio, :presence => {:message => "Debe ingresar Domicilio."}
  validate :pdescuento_val
  #validate :precargo_val
  before_save :pdescuento_set
  before_create :lista_asignada
  before_destroy :tiene_docs

  def tiene_docs
    errors.add(:facturas, "El cliente tiene facturas asociadas por lo que no puede eliminarse. ") if !self.facturas.empty?
    errors.add(:recibos, "El cliente tiene recibos asociados por lo que no puede eliminarse. ") if !self.recibos.empty?
    errors.blank?
  end

  def pdescuento_val
      if (!self.pdescuento.nil?)
        errors.add(:pdescuento,"No puede aplicar un descuento menor a 0 o mayor a 100. Es un porcentaje.") if (self.pdescuento < 0 or self.pdescuento > 100)
      end
  end

  def lista_asignada
    self.listaprecio = Listaprecio.find_by_predeterminada("1")
  end

  def pdescuento_set
    if !self.credito.nil? and self.credito?
      if (self.pdescuento.nil?)
        self.pdescuento = 0
      end
    end
  end

  def precargo_val
    if !self.credito.nil? and self.credito?
      if !self.precargo.nil?
        errors.add(:credito,"No puede aplicar un recargo menor a 0 o mayor a 100. Es un porcentaje.") if ( self.credito? and (self.precargo < 0 or self.precargo > 100 ))
      else
        errors.add(:credito,"Debe ingresar un porcentaje de recargo.")
      end
      if self.cantrecargo.nil?
        errors.add(:credito,"Debe ingresar una cantidad para el recargo.")
      end
      if self.urecargo.nil?
        errors.add(:credito,"Debe ingresar una unidad para el recargo.")
      end
    end
  end


end

