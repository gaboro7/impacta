# == Schema Information
#
# Table name: notadedebitos
#
#  id                :integer          not null, primary key
#  anulada           :boolean          default(FALSE)
#  rut               :string(255)      not null
#  direccion_cliente :string(255)      not null
#  codigo_barras     :string(255)
#  comerciante_id    :integer          not null
#  comerciante_type  :string(255)      not null
#  detalle           :string(255)
#  fecha             :date             not null
#  moneda_id         :integer          not null
#  nom_moneda        :string(255)
#  tipo_de_cambio    :float
#  impresa           :boolean          default(FALSE)
#  sucursal_id       :integer
#  adeudo            :float
#  numero            :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Notadedebito < DocumentoContable

  has_many :renglon_notadebitos, :dependent => :destroy
  has_many :renglon_ndddetalles, :dependent => :destroy
  has_many :renglon_nddndcs, :dependent => :destroy
  has_many :renglon_ndcndds
  has_many :renglon_recibo_docs
  belongs_to :comerciante, :polymorphic => true
  has_many :impresiones, :as => :imprimible
  has_many :movimientos, :as => :documento, :class_name => "MovimientoCliente"

  def cant_paginas
    @cant_renglones = self.renglon_notadebitos.size + self.renglon_ndddetalles.size + self.renglon_nddndcs.size
    (@cant_renglones / Setting.renglones_por_hoja) + (( @cant_renglones % Setting.renglones_por_hoja > 0 ) ? 1 : 0)
  end

  def nombre
    return "Nota de Debito"
  end

  def asignar_numero
    Notadedebito.transaction do

      @ndd_ant = Notadedebito.where("impresa = 1").order("numero DESC").first
      if !@ndd_ant.nil?
        self.numero = @ndd_ant.numero.next
      else
        self.numero = "A00001"
      end
    end
  end


  def anular

    if !self.anulada?
      if self.impresa?
        self.anulada = true
        @imprimio = true
        @imp = self.impresiones.where(:anulada => false)
        for i in @imp
          i.anulada = true
          i.save
        end
        @mov = MovimientoCliente.find(self.comerciante.movimientos.where("moneda_id = "+ self.moneda_id.to_s ).maximum("id"))
        @total = self.total_sinimpuestos + self.total_impuestos

        if self.sucursal_id.nil?
          self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s,:moneda_id => self.moneda_id, :debe => 0, :haber => @total,:saldo => @mov.saldo - @total)
        else
          @mov_suc = MovimientoCliente.find(self.comerciante.movimientos.where("moneda_id = " + self.moneda_id.to_s + " and sucursal_id = "+ self.sucursal_id.to_s ).maximum("id"))
          if Setting.saldo_cc_independiente
            self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :sucursal_id => self.sucursal_id, :fecha => Time.now.to_date.to_s,:moneda_id => self.moneda_id , :debe => 0, :haber => 0,:saldo => @mov.saldo, :debe_sucursal => 0, :haber_sucursal => @total,:saldo_sucursal => @mov_suc.saldo - @total)
          else
            self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :sucursal_id => self.sucursal_id, :fecha => Time.now.to_date.to_s,:moneda_id => self.moneda_id , :debe => 0, :haber => @total,:saldo => @mov.saldo - @total, :debe_sucursal => 0, :haber_sucursal => @total,:saldo_sucursal => @mov_suc.saldo - @total)
          end
        end
        for rr in self.renglon_notadebitos
          rr.factura.imprimio = true
          rr.factura.adeudo -= (rr.total_renglon - rr-total_impuestos)
          if !rr.factura.save
             return rr.factura.errors
          end
        end
      else
        errors.add(:anulada,"No puede anular una Nota de Debito que no fue impresa.")
      end
    else
      errors.add(:anulada, "La Nota de Debito ya fue anulada.")
    end
  end

  def imprimir(serie,numero)
    @imprimio = true
    ## mperez 22/06/2014 mantis 304
    #if !Impresione.exists?(:serie => serie,:numero => numero)
      if !self.anulada?

        if self.impresa?
          @imp = self.impresiones.where(:anulada => false)
          for i in @imp
            i.anulada = true
            i.save
          end
        else
          @total = self.total_sinimpuestos + self.total_impuestos
          if self.comerciante_type == "Cliente"
            @mov_id = self.comerciante.movimientos.where("moneda_id = "+ self.moneda_id.to_s).maximum("id")
            @mov_saldo = 0
            if !@mov_id.nil?
              @mov = MovimientoCliente.find( @mov_id )
              @mov_saldo = @mov.saldo
            end
            if self.sucursal_id.nil?
              self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id,  :debe => @total, :haber => 0,:saldo => @mov_saldo + @total)
            else

              @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ self.sucursal_id.to_s ).maximum("id")
              @mov_suc_saldo = 0
              if !@mov_suc_id.nil?
                @mov_suc = MovimientoCliente.find(@mov_suc_id)
                @mov_suc_saldo = @mov_suc.saldo
              end
              self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :sucursal_id => self.sucursal_id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id ,  :debe => @total, :haber => 0,:saldo => @mov_saldo + @total,  :debe_sucursal => @total, :haber_sucursal => 0,:saldo_sucursal => @mov_suc_saldo + @total)
            end
          end
        end
        if self.valid?
          if Setting.documentos_asociados
            for rr in self.renglon_notadebitos
                rr.factura.imprimio = true
                rr.factura.adeudo += rr.total_renglon + rr.total_impuestos
                if !rr.factura.save
                   return rr.factura.errors
                end
            end
          else
            self.adeudo = self.total
          end

          for rda in self.renglon_ndd_articulos
            for imp in rd.impuestos
              @fi=rda.foto_impuesto_ndds.create(:nombre => imp.nombre, :porcentaje => imp.porcentajea)
              @fi.save
            end
          end

          for rdb in self.renglon_notadebitos
            for imp in rd.impuestos
              @fi=rdb.foto_impuesto_ndds.create(:nombre => imp.nombre, :porcentaje => imp.porcentajea)
              @fi.save
            end
          end

          for rd in self.renglon_ndddetalles
            for imp in rd.impuestos
              @fi=rd.foto_impuesto_ndds.create(:nombre => imp.nombre, :porcentaje => imp.porcentajea)
              @fi.save
            end
          end

          self.impresiones.create(:serie => serie,:numero => numero,:anulada => false, :cant_paginas => self.cant_paginas)
          if !self.impresa
            self.asignar_numero()
            self.impresa = true
          end
        end
      else
        errors.add(:anulada, "La Nota de Debito se encuentra anulada.")
      end
    ## mperez 22/06/2014 mantis 304  
    #else
    #  if !self.impresa
    #    errors.add(:impresiones,"El par serie-numero pre-impreso ya fue utilizado.")
    #  end
    #end
  end

  def total_sinimpuestos
    @total = 0
    #for rf in self.renglon_notadebitos
    #  @total += rf.total_renglon
    #end
    #for rfd in self.renglon_ndddetalles
    #  @total += rfd.total_renglon
    #end

    if Setting.documentos_asociados
      @total += self.renglon_notadebitos.sum(:total_renglon)
      @total += self.renglon_ndddetalles.sum(:total_renglon)
    else
      @total += self.renglon_notadebitos.sum(:total_renglon)
      @total += self.renglon_ndd_articulos.sum(:total_renglon)
      @total += self.renglon_ndddetalles.sum(:total_renglon)
    end

    @total.round(2)
  end

  def total_impuestos
    @total = 0
    if Setting.documentos_asociados
      @total += self.renglon_notacreditos.sum(:total_impuestos)
      @total += self.renglon_ndcdetalles.sum(:total_impuestos)
    else
      @total += self.renglon_notacreditos.sum(:total_impuestos)
      @total += self.renglon_ndc_articulos.sum(:total_impuestos)
      @total += self.renglon_ndcdetalles.sum(:total_impuestos)
    end
    @total.round(2)
  end

  def total
    @total = self.total_impuestos + self.total_sinimpuestos
  end


  private


  validates :comerciante_id, :presence => {:message => "Debe asignar a un Cliente."}
  validates :fecha, :presence => {:message => "Debe asignar una Fecha."}
  validates :moneda, :presence => {:message => "Debe seleccionar una moneda."}
  validate :comerciante_val
  validate :impresa_val
  validate :anulada_val
  validate :anulada_impresa_val

  before_destroy :destroy_val?


  def destroy_val?
    errors.add(:impresa, "No puede modificar una Nota de Debito impresa.") if self.impresa?
    errors.blank?
  end


  def anulada_val
    errors.add(:anulada,"No puede modificar una Nota de Debito anulada.") if !(@imprimio == true) and self.anulada?
  end

  def anulada_impresa_val
    errors.add(:anulada,"No puede anular una Nota de Debito no impresa.") if !self.impresa? and self.anulada?
  end


  def impresa_val
    errors.add(:impresa,"No puede modificar una Nota de Debito impresa.") if !(@imprimio == true) and self.impresa?
  end

  def comerciante_val
    errors.add(:comerciante,"No dispone de credito.") if !self.comerciante.credito?
  end


end
