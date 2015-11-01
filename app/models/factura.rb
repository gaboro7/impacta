# == Schema Information
#
# Table name: facturas
#
#  id                :integer          not null, primary key
#  rut               :string(255)      not null
#  direccion_cliente :string(255)      not null
#  contado           :boolean          not null
#  detalle           :string(255)
#  fecha             :date             not null
#  codigo_barras     :string(255)
#  comerciante_id    :integer          not null
#  comerciante_type  :string(255)      not null
#  sucursal_id       :integer
#  formadepago_id    :integer
#  moneda_id         :integer          not null
#  nom_moneda        :string(255)
#  tipo_de_cambio    :float
#  impresa           :boolean          default(FALSE)
#  anulada           :boolean          default(FALSE)
#  adeudo            :float            default(0.0)
#  numero            :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Factura < DocumentoContable
  attr_accessor :imprimio
  attr_accessor :cambio_moneda

  #default_scope :order => "updated_at DESC"

  has_many :renglon_facturas, :dependent => :destroy#, :after_add => :articulo_repetido
  has_many :renglon_factdetalles, :dependent => :destroy
  has_many :renglon_recibos
  has_many :renglon_recdetalles
  has_many :renglon_recibo_docs, :as => :documento
  has_many :renglon_notacreditos
  has_many :renglon_notadebitos
  belongs_to :formadepago
  has_many :impresiones, :as => :imprimible, :dependent => :destroy
  has_many :movimientos, :as => :documento, :class_name => "MovimientoCliente"


  def vencida
    @vencio = false
    if !self.contado?
      @hoy = Time.now.to_date
      if (self.formadepago.unidad == :dia)
        #puts "111111"
        @vencio = @hoy > ( self.fecha.to_date + self.formadepago.cantidad.days)
      elsif (self.formadepago.unidad == :mes)
        @vencio = @hoy > ( self.fecha.to_date + self.formadepago.cantidad.month)
        #puts "222222"
      else
        @vencio = @hoy > ( self.fecha.to_date + self.formadepago.cantidad.years)
        #puts "333333333333"
      end
    end
    @vencio
  end

  def anulable
    (!self.anulada and self.renglon_recibos.joins(:recibo).where("anulada = 0 ").empty? and self.renglon_recdetalles.joins(:recibo).where("anulada = 0 ").empty? and self.renglon_recibo_docs.joins(:recibo).where("anulada = 0 ").empty? and self.renglon_notacreditos.joins(:notadecredito).where("anulada = 0 ").empty? and self.renglon_notadebitos.joins(:notadedebito).where("anulada = 0 ").empty? )
  end


  def anular
    ##################
    # Se puede llegar a anular si todos los renglones pertencen a recibos anulados
    # Igual con las notass
    ###########################
    ###########################
    ###########################

    if self.renglon_recibos.joins(:recibo).where("anulada = 0 ").empty? and self.renglon_recdetalles.joins(:recibo).where("anulada = 0 ").empty? and self.renglon_recibo_docs.joins(:recibo).where("anulada = 0 ").empty? and self.renglon_notacreditos.joins(:notadecredito).where("anulada = 0 ").empty? and self.renglon_notadebitos.joins(:notadedebito).where("anulada = 0 ").empty?
      if !self.anulada?
        if self.impresa?
          self.anulada = true
          @imprimio = true
          @imp = self.impresiones.where(:anulada => false)
          for i in @imp
            i.anulada = true
            i.save
          end
          if self.contado?
            @total = 0
          else
            @total = self.total_sinimpuestos + self.total_impuestos
          end

          if Setting.saldo_cc_independiente
            if (self.sucursal_id.nil?)
              @mov_id = self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id")
              @mov_saldo = 0
              if !@mov_id.nil?
                @mov = MovimientoCliente.find( @mov_id )
                @mov_saldo = @mov.saldo
              end
              self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => @total,:saldo => @mov_saldo - @total)
            else
              @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ self.sucursal_id.to_s ).maximum("id")
              @mov_suc_saldo = 0
              if !@mov_suc_id.nil?
                @mov_suc = MovimientoCliente.find(@mov_suc_id)
                @mov_suc_saldo = @mov_suc.saldo_sucursal
              end
              self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :sucursal_id => self.sucursal_id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0, :debe_sucursal => 0, :haber_sucursal => @total,:saldo_sucursal => @mov_suc_saldo - @total)
            end
          else
            @mov_id = self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id")
              @mov_saldo = 0
              if !@mov_id.nil?
                @mov = MovimientoCliente.find( @mov_id )
                @mov_saldo = @mov.saldo
              end
            if (self.sucursal_id.nil?)
              self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => @total,:saldo => @mov_saldo - @total)
            else
              @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ self.sucursal_id.to_s ).maximum("id")
              @mov_suc_saldo = 0
              if !@mov_suc_id.nil?
                @mov_suc = MovimientoCliente.find(@mov_suc_id)
                @mov_suc_saldo = @mov_suc.saldo_sucursal
              end
              self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :sucursal_id => self.sucursal_id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => @total,:saldo => @mov_saldo - @total, :debe_sucursal => 0, :haber_sucursal => @total,:saldo_sucursal => @mov_suc_saldo - @total)
            end
          end

          self.adeudo = 0
        else
          errors.add(:anulada,"No puede anular una Factura que no fue impresa.")
        end
      else
        errors.add(:anulada, "La Facutura ya fue anulada.")
      end
    else
       errors.add(:anulada,"La Factura tiene documentos no anulados asociados.")
    end
  end

  def imprimir(serie , numero)
    @imprimio = true
    ## mperez 22/06/2014 mantis 304
    #if !Impresione.exists?( :serie => serie, :numero => numero)
      if !self.anulada?

        if self.impresa?
          @imp = self.impresiones.where(:anulada => false)
          for i in @imp
            i.anulada = true
            i.save
          end
        else
          self.nom_moneda = self.moneda.nombre
          self.tipo_de_cambio = self.moneda.tipodecambio

          @total_haber = 0
          if self.contado?
            @total = self.total_sinimpuestos + self.total_impuestos
            @total_haber = @total
            self.adeudo = 0
          else
            self.adeudo = self.total_sinimpuestos + self.total_impuestos
            @total = self.adeudo
          end
          if self.comerciante_type == "Cliente"
            if !self.comerciante.movimientos.empty?
              if Setting.saldo_cc_independiente
                if ( self.sucursal_id.nil?)
                  @mov_id = self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id")
                  @mov_saldo = 0
                  if !@mov_id.nil?
                    @mov = MovimientoCliente.find( @mov_id )
                    @mov_saldo = @mov.saldo
                  end
                  self.movimientos.create(:operacion => "Impresion",:cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s ,:moneda_id => self.moneda_id , :debe => @total, :haber => @total_haber,:saldo => @mov_saldo + @total - @total_haber)
                else
                  @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ self.sucursal_id.to_s ).maximum("id")
                  @mov_suc_saldo = 0
                  if !@mov_suc_id.nil?
                    @mov_suc = MovimientoCliente.find(@mov_suc_id)
                    @mov_suc_saldo = @mov_suc.saldo_sucursal
                  end
                  self.movimientos.create(:operacion => "Impresion",:cliente_id => self.comerciante_id,:sucursal_id => self.sucursal_id, :fecha => Time.now.to_date.to_s,:moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0 , :debe_sucursal => @total, :haber_sucursal => @total_haber,:saldo_sucursal => @mov_suc_saldo + @total - @total_haber)
                end
              else
                @mov_id = self.comerciante.movimientos.where(" moneda_id = "+ self.moneda_id.to_s).maximum("id")
                @mov_saldo = 0
                if !@mov_id.nil?
                  @mov = MovimientoCliente.find( @mov_id )
                  @mov_saldo = @mov.saldo
                end
                if ( self.sucursal_id.nil?)
                  self.movimientos.create(:operacion => "Impresion",:cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s ,:moneda_id => self.moneda_id , :debe => @total, :haber => @total_haber,:saldo => @mov_saldo + @total - @total_haber)
                else
                  @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ self.sucursal_id.to_s ).maximum("id")
                  @mov_suc_saldo = 0
                  if !@mov_suc_id.nil?
                    @mov_suc = MovimientoCliente.find(@mov_suc_id)
                    @mov_suc_saldo = @mov_suc.saldo_sucursal
                  end
                  self.movimientos.create(:operacion => "Impresion",:cliente_id => self.comerciante_id,:sucursal_id => self.sucursal_id, :fecha => Time.now.to_date.to_s,:moneda_id => self.moneda_id, :debe => @total, :haber => @total_haber,:saldo => @mov_saldo + @total - @total_haber, :debe_sucursal => @total, :haber_sucursal => @total_haber,:saldo_sucursal => @mov_suc_saldo + @total - @total_haber)
                end
              end
            else
              if Setting.saldo_cc_independiente
                if ( self.sucursal_id.nil?)
                  self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id , :moneda_id => self.moneda_id, :fecha => Time.now.to_date.to_s , :debe => @total, :haber => @total_haber,:saldo => @total - @total_haber)
                else
                  self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id , :sucursal_id => self.sucursal_id, :moneda_id => self.moneda_id, :fecha => Time.now.to_date.to_s , :debe => 0, :haber => 0,:saldo => 0, :debe_sucursal => @total, :haber_sucursal => @total_haber,:saldo_sucursal => @total - @total_haber)
                end
              else
                if ( self.sucursal_id.nil?)
                  self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id , :moneda_id => self.moneda_id, :fecha => Time.now.to_date.to_s , :debe => @total, :haber => @total_haber,:saldo => @total - @total_haber)
                else
                  self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id , :sucursal_id => self.sucursal_id, :moneda_id => self.moneda_id, :fecha => Time.now.to_date.to_s , :debe => @total, :haber => @total_haber,:saldo => @total - @total_haber, :debe_sucursal => @total, :haber_sucursal => @total_haber,:saldo_sucursal => @total - @total_haber)
                end
              end
            end
          end

          if self.valid?
            for rf in self.renglon_facturas
              for imp in rf.comercializable.impuestos
                @fi = rf.foto_impuesto_facts.create(:nombre => imp.nombre, :porcentaje => imp.porcentajea)
                @fi.save
              end
            end
            for rd in self.renglon_factdetalles
              for imp in rd.impuestos
                @fi = rd.foto_impuesto_facts.create(:nombre => imp.nombre, :porcentaje => imp.porcentajea)
                @fi.save
              end
            end
          end

        end

        if !self.impresiones.create(:numero => numero,:serie => serie,:anulada => false , :cant_paginas => self.cant_paginas)
          error.add(:impresiones, self.impresiones.errors.messages)
        else
          if !self.impresa
            self.impresa = true
            self.asignar_numero
          end
        end
      else
        errors.add(:anulada, "La Factura se encuentra anulada.")
      end
    ## mperez 22/06/2014 mantis 304
    #else
    #  if !self.impresa
    #    errors.add(:impresiones,"El par serie-numero pre-impreso ya fue utilizado.")
    #  end
    #end
  end

  def total
    @total = total_sinimpuestos + total_impuestos
  end

  def total_sinimpuestos
    @total = 0
    @total += self.renglon_facturas.sum("total_renglon")
    @total += self.renglon_factdetalles.sum("total_renglon")
    @total.round(2)
  end

  def subtotal
    @total = 0
    if self.renglon_facturas.length > 0
      @total += self.renglon_facturas.sum("precio_unitario * cantidad")
    end
    @total += self.renglon_factdetalles.sum("total_renglon")

    @total.round(2)
  end

  def total_impuestos
    @total = 0
    @total += self.renglon_facturas.sum("total_impuestos")
    @total += self.renglon_factdetalles.sum("total_impuestos")
    @total.round(2)
  end

  def total_impuestos_discriminado
    @config   = Rails.configuration.database_configuration
    @database = @config[Rails.env]["database"]
    @total = Factura.connection.select_all("select distinct(nombre) as nombre, sum(imp) as imp
              from (
                  select  rif.nombre as nombre, rf.total_renglon*(rif.porcentaje/100) as imp
                  from " + @database + ".renglon_facturas as rf
                  join " + @database + ".foto_impuesto_facts as rif on (rif.renglon_id = rf.id and rif.renglon_type = 'RenglonFactura')
                  where rf.factura_id = "+self.id.to_s+"
                  UNION ALL
                  select  rif.nombre as nombre, rd.total_renglon*(rif.porcentaje/100) as imp
                  from " + @database + ".renglon_factdetalles as rd
                  join " + @database + ".foto_impuesto_facts as rif on (rif.renglon_id = rd.id and rif.renglon_type = 'RenglonFactdetalle')
                  where rd.factura_id = "+self.id.to_s+"
              ) as impuestos
              group by nombre;")
  end

  def total_pago_sinimpuestos
    self.renglon_recibos.sum("total_renglon").round(2)
  end

  def total_pago_imp
    self.renglon_recibos.sum("total_impuestos").round(2)
  end

  def asignar_numero
    Factura.transaction do

      #@imp = Impresione.where("imprimible_type = 'Factura'").joins(:joins => "INNER JOIN forum_topics ON forum_topics.id = comments.commentable_id").where("contado = ?", self.contado ? 1 : 0).maximum("updated_at")
      @fact_ant = Factura.where("contado = ? and impresa = 1", self.contado ? 1 : 0).order("numero DESC").first
      if !@fact_ant.nil?
        self.numero = @fact_ant.numero.next
      else
        self.numero = "A00001"
      end
    end
  end

  def cant_paginas
    @cant_renglones = self.renglon_facturas.size + self.renglon_factdetalles.size
    (@cant_renglones / Setting.renglones_por_hoja) + (( @cant_renglones % Setting.renglones_por_hoja > 0 ) ? 1 : 0)
  end


  private

  validates :comerciante_id, :presence => {:message => "Debe asignar a un Cliente."}
  validates :formadepago, :presence => {:message => "Debe asignar una Forma de Pago."}
  validates :fecha, :presence => {:message => "Debe asignar una Fecha."}
  validates :moneda, :presence => {:message => "Debe asignar una Moneda"}
  validate :recibos_credito
  validate :adeudo_val
  validate :comerciante_val
  validate :impresa_val
  validate :moneda_val
  validate :anulada_val
  validate :direccion_cliente_val
  validate :rut_val

  before_destroy :destroy_val?
  after_update :actualizar_moneda

  def direccion_cliente_val
    errors.add(:direccion_cliente,"Debe ingresar una direccion.") if self.direccion_cliente.nil? or self.direccion_cliente == ""
  end

  def rut_val
    errors.add(:direccion_cliente,"Debe ingresar un numero de rut.") if self.comerciante.class.name == "Empresa" and (self.rut.nil? or self.rut == "" )
  end

  def actualizar_moneda
    if self.valid? and (!self.cambio_moneda.nil?)and (self.cambio_moneda > 0)
      for rf in self.renglon_facturas
        rf.total_renglon = rf.total_renglon*self.cambio_moneda/self.moneda.tipodecambio
        rf.total_impuestos = rf.total_impuestos*self.cambio_moneda/self.moneda.tipodecambio
        rf.precio_unitario = rf.precio_unitario*self.cambio_moneda/self.moneda.tipodecambio
        rf.save
      end

      for rd in self.renglon_factdetalles
        rd.total_renglon = rd.total_renglon*self.cambio_moneda/self.moneda.tipodecambio
        rd.total_impuestos = rd.total_impuestos*self.cambio_moneda/self.moneda.tipodecambio
        rd.precio_unitario = rd.precio_unitario*self.cambio_moneda/self.moneda.tipodecambio
        rd.save
      end
    end
  end

  def destroy_val?
    errors.add(:impresa, "No puede modificar una Factura impresa.") if self.impresa?
    errors.blank?
  end


  def anulada_val
    errors.add(:anulada,"No puede modificar una Factura anulada.") if !(@imprimio == true) and self.anulada?
  end



  def anulada_impresa_val
    errors.add(:anulada,"No puede anular una Factura no impresa.") if !self.impresa? and self.anulada?
  end


  def impresa_val
    errors.add(:impresa,"No puede modificar una Factura impresa.") if !(@imprimio == true) and self.impresa?
  end

  def moneda_val
    if !self.formadepago.nil?
      errors.add(:moneda, "La moneda seleccionada no forma parte de la Forma de Pago.") if !self.formadepago.moneda.exists?(self.moneda)
    end
  end

  def comerciante_val
    errors.add(:comerciante,"No dispone de credito.") if !self.contado? and !self.comerciante.credito?
  end


  def recibos_credito
      errors.add(:renglon_recibos,"No se puede asignar un recibo a una factura contado.") if (self.contado? and !(self.renglon_recibos.empty?))
  end

  def adeudo_val
    errors.add(:adeudo, "No puede superar el importe adeudado de la factura " + self.id.to_s + " ." ) if self.adeudo < -1
  end

  #def articulo_repetido(renglon_factura)
  #  errors.add(:renglon_factura, renglon_factura.errors.messages)
  #end


end
