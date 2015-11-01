# == Schema Information
#
# Table name: notadecreditos
#
#  id                :integer          not null, primary key
#  anulada           :boolean          default(FALSE)
#  es_devolucion     :boolean          default(FALSE)
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
#  numero            :string(255)
#  adeudo            :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Notadecredito < DocumentoContable

  attr_accessor :imprimio

  has_many :renglon_notacreditos, :dependent => :destroy
  has_many :renglon_ndcdetalles, :dependent => :destroy
  has_many :renglon_ndcndds, :dependent => :destroy
  has_many :renglon_nddndcs
  has_many :renglon_ndc_articulos, :dependent => :destroy
  has_many :renglon_recibo_docs, :as => :documento
  belongs_to :comerciante, :polymorphic => true
  has_many :impresiones, :as => :imprimible
  has_many :movimientos, :as => :documento, :class_name => "MovimientoCliente"

  def nombre
    "Nota de Credito"
  end

  def anulable
    (!self.anulada and self.renglon_recibo_docs.joins(:recibo).where("anulada = 0 ").empty? and self.renglon_nddndcs.joins(:notadedebito).where("anulada = 0 ").empty? )
  end

  def asignar_numero
    Notadecredito.transaction do

      #@imp = Impresione.where("imprimible_type = 'Factura'").joins(:joins => "INNER JOIN forum_topics ON forum_topics.id = comments.commentable_id").where("contado = ?", self.contado ? 1 : 0).maximum("updated_at")
      @ndc_ant = Notadecredito.where("es_devolucion = ? and impresa = 1", self.es_devolucion ? 1 : 0).order("numero DESC").first
      if !@ndc_ant.nil?
        self.numero = @ndc_ant.numero.next
      else
        self.numero = "A00001"
      end
    end
  end

  def anular
    if true
      if !self.anulada?
        if self.impresa?
          self.anulada = true
          @imprimio = true
          @imp = self.impresiones.where(:anulada => false)
          for i in @imp
            i.anulada = true
            i.save
          end


          ###########################################################
          if Setting.saldo_cc_independiente

            if self.sucursal_id.nil?

              for rr in self.renglon_notacreditos
                @total = rr.total_renglon + rr.total_impuestos
                @total_haber = 0
                if self.es_devolucion
                  @total_haber = @total
                end
                if !rr.factura.sucursal.nil?

                  @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                  @mov_suc_saldo = 0
                  if !@mov_suc_id.nil?
                    @mov_suc = MovimientoCliente.find(@mov_suc_id)
                    @mov_suc_saldo = @mov_suc.saldo_sucursal
                  end
                  self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0, :debe_sucursal => @total, :haber_sucursal => @total_haber,:saldo_sucursal => @mov_suc_saldo + rr.total_renglon - @total_haber)
                else
                  @mov = MovimientoCliente.find(self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id"))
                  self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => @total, :haber => @total_haber,:saldo => @mov.saldo + @total - @total_haber)
                end
              end

              for rr in self.renglon_ndcdetalles
                @total = rr.total_renglon + rr.total_impuestos
                @total_haber = 0
                if self.es_devolucion
                  @total_haber = @total
                end
                if !rr.factura.nil? and !rr.factura.sucursal.nil?

                  @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                  @mov_suc_saldo = 0
                  if !@mov_suc_id.nil?
                    @mov_suc = MovimientoCliente.find(@mov_suc_id)
                    @mov_suc_saldo = @mov_suc.saldo_sucursal
                  end
                  self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0, :debe_sucursal => @total, :haber_sucursal => @total_haber,:saldo_sucursal => @mov_suc_saldo + rr.total_renglon - @total_haber)
                else
                  @mov = MovimientoCliente.find(self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id"))
                  self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => @total, :haber => @total_haber,:saldo => @mov.saldo + @total - @total_haber)
                end
              end

              if self.renglon_ndc_articulos.size > 0
                @total = self.renglon_ndc_articulos.sum('total_renglon + total_impuestos')
                @total_haber = 0
                if self.es_devolucion
                  @total_haber = @total
                end
                @mov = MovimientoCliente.find(self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id"))
                self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => @total, :haber => @total_haber ,:saldo => @mov.saldo + @total - @total_haber )
              end

            else
  ############ Alvarinho: faltan los movimientos de los demás renglones cuando es sucursal, por algo en especial? igual creo que ya casé pero dejo planteada la pregunta
              @total = 0
              #if self.renglon_ndc_articulos.size > 0
              #  @total = self.renglon_ndc_articulos.sum('total_renglon + total_impuestos')
              #end
              @total = self.total
              @total_haber = 0
              if self.es_devolucion
                @total_haber = @total
              end
              @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ self.sucursal_id.to_s ).maximum("id")
              @mov_suc_saldo = 0
              if !@mov_suc_id.nil?
                @mov_suc = MovimientoCliente.find(@mov_suc_id)
                @mov_suc_saldo = @mov_suc.saldo_sucursal
              end
              self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :sucursal_id => self.sucursal_id,:fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0, :debe_sucursal => @total, :haber_sucursal => @total_haber ,:saldo_sucursal => @mov_suc_saldo + @total - @total_haber )
            end
          else
            @mov = MovimientoCliente.find(self.comerciante.movimientos.where("moneda_id = "+ self.moneda_id.to_s).maximum("id"))

            if self.sucursal_id.nil?

              for rr in self.renglon_notacreditos
                @total = rr.total_renglon + rr.total_impuestos
                @total_haber = 0
                if self.es_devolucion
                  @total_haber = @total
                end
                if !rr.factura.sucursal.nil?

                  @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                  @mov_suc_saldo = 0
                  if !@mov_suc_id.nil?
                    @mov_suc = MovimientoCliente.find(@mov_suc_id)
                    @mov_suc_saldo = @mov_suc.saldo_sucursal
                  end
                  self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => @mov.saldo , :debe_sucursal => @total, :haber_sucursal => @total_haber,:saldo_sucursal => @mov_suc_saldo + rr.total_renglon - @total_haber)
                end
              end

              for rr in self.renglon_ndcdetalles
                @total = rr.total_renglon + rr.total_impuestos
                @total_haber = 0
                if self.es_devolucion
                  @total_haber = @total
                end
                if !rr.factura.nil? and !rr.factura.sucursal.nil?

                  @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                  @mov_suc_saldo = 0
                  if !@mov_suc_id.nil?
                    @mov_suc = MovimientoCliente.find(@mov_suc_id)
                    @mov_suc_saldo = @mov_suc.saldo_sucursal
                  end
                  self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => @mov.saldo, :debe_sucursal => @total, :haber_sucursal => @total_haber,:saldo_sucursal => @mov_suc_saldo + rr.total_renglon - @total_haber)
                end
              end
              @total = self.total
              @total_haber = 0
              if self.es_devolucion
                @total_haber = @total
              end
              self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => @total, :haber => @total_haber,:saldo => @mov.saldo + @total - @total_haber)
            else
              @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ self.sucursal_id.to_s ).maximum("id")
              @mov_suc_saldo = 0
              if !@mov_suc_id.nil?
                @mov_suc = MovimientoCliente.find(@mov_suc_id)
                @mov_suc_saldo = @mov_suc.saldo_sucursal
              end
              @total = self.total
              @total_haber = 0
              if self.es_devolucion
                @total_haber = @total
              end
              self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :sucursal_id => self.sucursal_id,:fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => @total, :haber => @total_haber ,:saldo => @mov.saldo + @total - @total_haber , :debe_sucursal => @total, :haber_sucursal => @total_haber ,:saldo_sucursal => @mov_suc_saldo + @total - @total_haber )
            end

          end




          #########################################################3


          if Setting.documentos_asociados
            for rr in self.renglon_notacreditos
                rr.factura.imprimio = true
                rr.factura.adeudo += rr.total_renglon + rr.total_impuestos
                if !rr.factura.save
                   return rr.factura.errors
                end
            end
          else
            self.adeudo = 0
          end

        else
          errors.add(:anulada,"No puede anular una Nota de Credito que no fue impresa.")
        end
      else
        errors.add(:anulada, "La Nota de Credito ya fue anulada.")
      end
    else
      errors.add(:anulada, "La Nota de Credito tiene documentos asociados.")
    end
  end

  def imprimir(serie, numero)
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
          if self.comerciante_type == "Cliente"
            if Setting.saldo_cc_independiente
              if self.sucursal_id.nil?

                for rr in self.renglon_notacreditos
                  @total = rr.total_renglon + rr.total_impuestos
                  @total_debe = 0
                  if self.es_devolucion
                    @total_debe = @total
                  end
                  if !rr.factura.sucursal.nil?

                    @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                    @mov_suc_saldo = 0
                    if !@mov_suc_id.nil?
                      @mov_suc = MovimientoCliente.find(@mov_suc_id)
                      @mov_suc_saldo = @mov_suc.saldo_sucursal
                    end
                    self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0, :debe_sucursal => @total_debe , :haber_sucursal => @total,:saldo_sucursal => @mov_suc_saldo - @total + @total_debe )
                  else
                    @mov_id = self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id")
                    @mov_saldo = 0
                    if !@mov_id.nil?
                      @mov = MovimientoCliente.find( @mov_id )
                      @mov_saldo = @mov.saldo
                    end
                    self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => @total_debe , :haber => @total,:saldo => @mov_saldo - @total + @total_debe )
                  end
                end

                for rr in self.renglon_ndcdetalles
                  @total = rr.total_renglon + rr.total_impuestos
                  @total_debe = 0
                  if self.es_devolucion
                    @total_debe = @total
                  end
                  if !rr.factura.nil? and !rr.factura.sucursal.nil?

                    @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                    @mov_suc_saldo = 0
                    if !@mov_suc_id.nil?
                      @mov_suc = MovimientoCliente.find(@mov_suc_id)
                      @mov_suc_saldo = @mov_suc.saldo_sucursal
                    end
                    self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0, :debe_sucursal => @total_debe , :haber_sucursal => @total,:saldo_sucursal => @mov_suc_saldo - rr.total_renglon + @total_debe )
                  else
                    @mov_id = self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id")
                    @mov_saldo = 0
                    if !@mov_id.nil?
                      @mov = MovimientoCliente.find( @mov_id )
                      @mov_saldo = @mov.saldo
                    end
                    self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => @total_debe , :haber => @total,:saldo => @mov_saldo - @total + @total_debe )
                  end
                end

                @total = 0
                if self.renglon_ndc_articulos.size > 0
                  @total = self.renglon_ndc_articulos.sum('total_renglon + total_impuestos')
                  @total_debe = 0
                  if self.es_devolucion
                    @total_debe = @total
                  end
                  @mov_id = self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id")
                  @mov_saldo = 0
                  if !@mov_id.nil?
                    @mov = MovimientoCliente.find( @mov_id )
                    @mov_saldo = @mov.saldo
                  end
                  self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => @total_debe , :haber => @total,:saldo => @mov_saldo - @total + @total_debe )
                end

              else

                @total = 0
                #if self.renglon_ndc_articulos.size > 0
                #  @total = self.renglon_ndc_articulos.sum('total_renglon + total_impuestos')
                #end
                @total = self.total
                @total_debe = 0
                if self.es_devolucion
                  @total_debe = @total
                end
                @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ self.sucursal_id.to_s ).maximum("id")
                @mov_suc_saldo = 0
                if !@mov_suc_id.nil?
                  @mov_suc = MovimientoCliente.find(@mov_suc_id)
                  @mov_suc_saldo = @mov_suc.saldo_sucursal
                end
                self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :sucursal_id => self.sucursal_id,:fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0, :debe_sucursal => @total_debe , :haber_sucursal => @total,:saldo_sucursal => @mov_suc_saldo - @total + @total_debe )
              end
            else
              @mov = MovimientoCliente.find(self.comerciante.movimientos.where("moneda_id = "+ self.moneda_id.to_s).maximum("id"))

              if self.sucursal_id.nil?

                for rr in self.renglon_notacreditos

                  if !rr.factura.sucursal.nil?
                    @total = rr.total_renglon + rr.total_impuestos
                    @total_debe = 0
                    if self.es_devolucion
                      @total_debe = @total
                    end
                    @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                    @mov_suc_saldo = 0
                    if !@mov_suc_id.nil?
                      @mov_suc = MovimientoCliente.find(@mov_suc_id)
                      @mov_suc_saldo = @mov_suc.saldo_sucursal
                    end
                    self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => @mov.saldo , :debe_sucursal => @total_debe , :haber_sucursal => @total,:saldo_sucursal => @mov_suc_saldo - @total + @total_debe )
                  end
                end

                for rr in self.renglon_ndcdetalles

                  if !rr.factura.nil? and !rr.factura.sucursal.nil?
                    @total = rr.total_renglon + rr.total_impuestos
                    @total_debe = 0
                    if self.es_devolucion
                      @total_debe = @total
                    end
                    @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                    @mov_suc_saldo = 0
                    if !@mov_suc_id.nil?
                      @mov_suc = MovimientoCliente.find(@mov_suc_id)
                      @mov_suc_saldo = @mov_suc.saldo_sucursal
                    end
                    self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => @mov.saldo, :debe_sucursal => @total_debe , :haber_sucursal => @total,:saldo_sucursal => @mov_suc_saldo - rr.total_renglon + @total_debe )
                  end
                end
                @total = self.total
                @total_debe = 0
                if self.es_devolucion
                  @total_debe = @total
                end
                self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => @total, :haber => @total_debe ,:saldo => @mov.saldo - @total + @total_debe )
              else
                @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ self.sucursal_id.to_s ).maximum("id")
                @mov_suc_saldo = 0
                if !@mov_suc_id.nil?
                  @mov_suc = MovimientoCliente.find(@mov_suc_id)
                  @mov_suc_saldo = @mov_suc.saldo_sucursal
                end
                @total = self.total
                @total_debe = 0
                if self.es_devolucion
                  @total_debe = @total
                end
                self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :sucursal_id => self.sucursal_id,:fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => @total_debe , :haber => @total,:saldo => @mov.saldo - @total + @total_debe , :debe_sucursal => @total_debe , :haber_sucursal => @total,:saldo_sucursal => @mov_suc_saldo - @total + @total_debe )
              end

            end
          end

          ################################

          if self.valid?
            if (!self.es_devolucion)
               if Setting.documentos_asociados
                 #baja el adeudo de las facturas
                 for rr in self.renglon_notacreditos
                      rr.factura.imprimio = true
                      rr.factura.adeudo -= (rr.total_renglon + rr.total_impuestos)
                      if !rr.factura.save
                         return rr.factura.errors
                      end
                 end
               end
               self.adeudo = -self.total
            else
               self.adeudo = 0
            end

            for rr in self.renglon_notacreditos
                for imp in rr.comercializable.impuestos
                  @fi=rr.foto_impuesto_ndcs.create(:nombre => imp.nombre, :porcentaje => imp.porcentajea)
                  @fi.save
                end
            end

            for rr in self.renglon_ndc_articulos
                for imp in rr.comercializable.impuestos
                  @fi=rr.foto_impuesto_ndcs.create(:nombre => imp.nombre, :porcentaje => imp.porcentajea)
                  @fi.save
                end
            end

            for rd in self.renglon_ndcdetalles
              for imp in rd.impuestos
                @fi=rd.foto_impuesto_ndcs.create(:nombre => imp.nombre, :porcentaje => imp.porcentajea)
                @fi.save
              end
            end

          end

          self.impresiones.create(:serie => serie,:numero => numero,:anulada => false, :cant_paginas => self.cant_paginas)
          if !self.impresa
            self.asignar_numero
            self.impresa = true
          end
        end
      else
        errors.add(:anulada, "La Nota de Credito se encuentra anulada.")
      end
    ## mperez 22/06/2014 mantis 304
    #else
    #  if !self.impresa
    #   errors.add(:impresiones,"El par serie-numero pre-impreso ya fue utilizado.")
    #  end
    #end
  end

  def total_sinimpuestos
    @total = 0
    #for rf in self.renglon_notacreditos
    #  @total += rf.total_renglon
    #end
    #for rfd in self.renglon_ndcdetalles
    #  @total += rfd.total_renglon
    #end
    if Setting.documentos_asociados
      @total += self.renglon_notacreditos.sum(:total_renglon)
      @total += self.renglon_ndcdetalles.sum(:total_renglon)
    else
      @total += self.renglon_notacreditos.sum(:total_renglon)
      @total += self.renglon_ndc_articulos.sum(:total_renglon)
      @total += self.renglon_ndcdetalles.sum(:total_renglon)
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

  def total_impuestos_discriminado
    @total = Factura.connection.select_all("select  distinct(rindc.nombre), sum(rndc.total_renglon*(rindc.porcentaje/100)) as imp
              from prodfactpand.renglon_ndc_articulos as rndc
              join prodfactpand.foto_impuesto_ndcs as rindc on (rindc.renglon_id = rndc.id and rindc.renglon_type = 'RenglonNdcArticulo')
              where rndc.notadecredito_id = "+self.id.to_s+"
              group by rindc.nombre;")
  end

  def subtotal
    @total = 0


    #if Setting.documentos_asociados
     # @total += self.renglon_notacreditos.sum("total_renglon")
     # @total += self.renglon_ndcdetalles.sum("total_renglon")
    #else
    if self.renglon_notacreditos.length > 0
      @total += self.renglon_notacreditos.sum("total_renglon")
    end
    if self.renglon_ndc_articulos.length > 0
      @total += self.renglon_ndc_articulos.sum("precio_unitario * cantidad")
    end
    if self.renglon_ndcdetalles.length > 0
      @total += self.renglon_ndcdetalles.sum("total_renglon")

    end
    #end

    @total.round(2)
  end

  def total
    @total = 0
    #for rf in self.renglon_notacreditos
    #  @total += rf.total_impuestos
    #end
    #for rfd in self.renglon_ndcdetalles
    #  @total += rfd.total_impuestos
    #end

    if Setting.documentos_asociados
      @total += self.renglon_notacreditos.sum(:total_renglon)
      @total += self.renglon_ndcdetalles.sum(:total_renglon)
      @total += self.renglon_notacreditos.sum(:total_impuestos)
      @total += self.renglon_ndcdetalles.sum(:total_impuestos)
    else
      @total += self.renglon_notacreditos.sum(:total_renglon)
      @total += self.renglon_notacreditos.sum(:total_impuestos)
      @total += self.renglon_ndc_articulos.sum(:total_renglon)
      @total += self.renglon_ndcdetalles.sum(:total_renglon)
      @total += self.renglon_ndc_articulos.sum(:total_impuestos)
      @total += self.renglon_ndcdetalles.sum(:total_impuestos)
    end

    @total.round(2)
  end


  def cant_paginas
    @cant_renglones = self.renglon_notacreditos.size + self.renglon_ndc_articulos.size + self.renglon_ndcdetalles.size + self.renglon_ndcndds.size
    (@cant_renglones / Setting.renglones_por_hoja) + (( @cant_renglones % Setting.renglones_por_hoja > 0 ) ? 1 : 0)
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
    errors.add(:impresa, "No puede modificar una Nota de Credito impresa.") if self.impresa?
    errors.blank?
  end


  def anulada_val
    errors.add(:anulada,"No puede modificar una Nota de Credito anulada.") if !(@imprimio == true) and self.anulada?
  end

  def anulada_impresa_val
    errors.add(:anulada,"No puede anular una Nota de Credito no impresa.") if !self.impresa? and self.anulada?
  end


  def impresa_val
    errors.add(:impresa,"No puede modificar una Nota de Credito impresa.") if !(@imprimio == true) and self.impresa?
  end

  def comerciante_val
    errors.add(:comerciante,"No dispone de credito.") if !self.comerciante.credito?
  end


end
