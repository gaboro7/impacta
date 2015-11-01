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

class Comercializable < Rolarticulo

  has_many :comercializables_impuesto
  has_many :impuestos, :through => :comercializables_impuesto
  
  has_many :comercializables_promocions
  has_many :promocions, :through => :comercializables_promocions
  
  has_many :precioarts
  has_many :descuento_clientes
  public
  
  def get_promocion_actual(cliente_id, formadepago_id)
    @hoy = Time.now.to_date
    return self.promocions.joins(:cliente,:formadepago).where("fechainicio <= '"+ @hoy.to_s + "' and fechafin >= '"+ @hoy.to_s + "' and cliente_id = '"+ cliente_id.to_s + "' and formadepago_id = '" + formadepago_id.to_s + "'")
  end

  def self.get_comercializable_cliente(id)
     @precio_articulo = Precioart.where("listaprecio_id  = ?",id);
     @id_list =  Array.new()
     @precio_articulo.each {|index|  
        @id_list.push(index.comercializable_id)
     }
     return self.where("id in (" + @id_list.join(",") + ")")
    #return @precio_articulo.comercializable;
  end

   def self.get_comercializable_cliente_filter(id,filter)
     #@conf_busqueda_articulos configuracion de la busqueda
     # 1: busqueda por coincidencia exacta primero despues por empieza luego por contiene (en los parametros id y nombre) y las concatena
     # 0: busca por contiene (en los parametros id y nombre)
     @conf_busqueda_articulos = 1

     @precio_articulo = Precioart.where("listaprecio_id  = ?",id);
     @id_list =  Array.new()
     @precio_articulo.each {|index|
        @id_list.push(index.comercializable_id)
     }
      @conf = 0
      if (@conf_busqueda_articulos == 1)
        @articuloinds1 = Articuloind.where("id in (" + @id_list.join(",") + ") and (id like '"+filter.to_s+"')")
        @articuloinds2 = Articuloind.where("id in (" + @id_list.join(",") + ") and (nombre like '"+filter.to_s+"' and id not like '"+filter.to_s+"')")
        @articuloinds3 = Articuloind.where("id in (" + @id_list.join(",") + ") and (nombre like '%"+filter.to_s+"' and not (id like '"+filter.to_s+"' or nombre like '"+filter.to_s+"'))")
        @articuloinds4 = Articuloind.where("id in (" + @id_list.join(",") + ") and (nombre like '%"+filter.to_s+"%' or id like '%"+filter.to_s+"%') and not (nombre like '%"+filter.to_s+"' or id like '"+filter.to_s+"')")
        @articuloinds = @articuloinds1 + @articuloinds2 + @articuloinds3 + @articuloinds4
      else
        @articuloinds = Articuloind.where("id in (" + @id_list.join(",") + ") and (nombre like '%"+filter.to_s+"%' or id like '%"+filter.to_s+"%')")
      end
     return @articuloinds
    #return @precio_articulo.comercializable;
  end

  private

  validate :descuento_val
  validates_numericality_of :descuento, :message => "El caracter de separacion decimal es .(Punto)."

  after_save :descuento_set




  def descuento_set
    if self.descuento.nil?
      self.descuento = 0
      self.save
    end

  end


  def descuento_val
    if !self.descuento.nil?
      errors.add(:descuento,"El descuento tiene que ser un numero entre 0 y 100.") if self.descuento < 0 or self.descuento > 100
    end
  end

end

