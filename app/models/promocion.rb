# encoding: utf-8

# == Schema Information
#
# Table name: promocions
#
#  id          :integer          not null, primary key
#  fechainicio :date             not null
#  fechafin    :date             not null
#  descuento   :float            default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  descripcion :string(255)
#

class Promocion < ActiveRecord::Base
  has_many :formadepagos_promocion
  has_many :formadepago, :through => :formadepagos_promocion
  
  has_many :comercializables_promocion
  has_many :comercializable, :through => :comercializables_promocion
  has_many :clientes_promocion
  has_many :cliente, :through => :clientes_promocion

  private

  validates :fechainicio, :presence => {:message => "Debe ingresar una Fecha de Inicio."}
  validates :fechafin, :presence => {:message => "Debe ingresar una Fecha de Fin."}
  validates :descuento, :presence => {:message => "Debe asignar un Descuento."}
  validates_numericality_of :descuento, :message => "El caracter de separacion decimal es .(Punto)."

  validate :formadepago_val
  validate :comercializable_val
  validate :fechainicio_val , :on => :create
  validate :fechafin_val
  validate :descuento_val
  validate :promociones_anteriores
  validate :fechas_val


  def promociones_anteriores
    query = "select p.descripcion, cl.cliente_id, f.formadepago_id, c.comercializable_id
              from promocions p
              inner join clientes_promocions as cl on (cl.promocion_id = p.id)
              inner join formadepagos_promocions as f on (f.promocion_id = p.id)
              inner join comercializables_promocions as c on (c.promocion_id = p.id)
              where not (  "+self.fechafin.to_date.to_s+" <= p.fechainicio and p.fechafin <= "+self.fechainicio.to_date.to_s+")"
    if  !self.id.nil?
      query +=" and p.id <> " + self.id.to_s
    end        
    query += ";"

    data = ActiveRecord::Base.connection.execute(query);
    if data.size > 0
      p = 0
      for cl in self.cliente
        for f in self.formadepago
          for c in self.comercializable
            @msg = ""
            data.each do |da|
              if da[1] == cl.id and da[2] == f.id and da[3] == c.id
                @msg += "Esta promoción tiene períodos superpuestos con la promoción " + da[0] + " para el cliente " + cl.nombrereal + ", el artículo " + c.rola.nombre + " y la forma de pago " + f.nombre
                errors.add(:comercializable, @msg)       
              end
            end
          end     
        end
      end
    end
  end

  def formadepago_val
    errors.add(:formadepago, "Debe asociar por lo menos una Forma de pago.") if self.formadepago.empty?
  end
  
  def comercializable_val
    errors.add(:comercializable, "Debe asociar por lo menos a un Articulo.") if self.comercializable.empty?
  end

  def fechainicio_val
    if ( !self.fechainicio.nil? and !self.fechafin.nil? )
      errors.add(:fechainicio,"La Fecha de Inicio no puede ser anterior a al fecha actual.") if ((self.fechainicio.year < Time.now.year) or ((self.fechainicio.year == Time.now.year)) and (self.fechainicio.month < Time.now.month) or ( ((self.fechainicio.year == Time.now.year)) and (self.fechainicio.month == Time.now.month) and (self.fechainicio.day < Time.now.day)))
    end
  end

  def fechafin_val
    if ( !self.fechafin.nil? )
      puts "RRRRRRRRRRRRRRRRRRRRR" + Time.now.to_s + "    " + self.fechafin.to_s
      errors.add(:fechafin,"La fecha de fin no debe ser antes de ayer.") if ((self.fechafin.year < Time.now.year) or ((self.fechafin.year == Time.now.year) and (self.fechafin.month < Time.now.month)) or  ((self.fechafin.year == Time.now.year) and (self.fechafin.month == Time.now.month) and (self.fechafin.day < (Time.now.day - 1))))
    end
  end

  def fechas_val
    if (!self.fechainicio.nil? and !self.fechafin.nil?)
      errors.add(:fechafin,"La fecha de Cierre no debe ser anterior a la Fecha de Inicio.") if (self.fechafin < self.fechainicio)
    end
  end


  def descuento_val
    if !self.descuento.nil?
      errors.add(:descuento,"El descuento tiene que ser un numero entre 0 y 100.") if self.descuento < 0 or self.descuento > 100
    end
  end
  
end
