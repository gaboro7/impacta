# == Schema Information
#
# Table name: recibos
#
#  id                :integer          not null, primary key
#  fecha             :date             not null
#  codigo_barras     :string(255)
#  detalle           :string(255)
#  rut               :string(255)      not null
#  direccion_cliente :string(255)      not null
#  pagocontado_id    :integer          not null
#  comerciante_id    :integer          not null
#  comerciante_type  :string(255)      not null
#  sucursal_id       :integer
#  moneda_id         :integer          not null
#  nom_moneda        :string(255)
#  tipo_de_cambio    :float
#  impresa           :boolean          default(FALSE)
#  anulada           :boolean          default(FALSE)
#  numero            :string(255)
#  manual            :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Recibo < DocumentoContable


  attr_accessor :desde
  attr_accessor :hasta
  attr_accessor :con_suc
  attr_accessor :imprimio

  has_many :renglon_recibos, :dependent => :destroy
  has_many :renglon_recdetalles, :dependent => :destroy
  has_many :renglon_recibo_docs, :dependent => :destroy
  belongs_to :pagocontado
  has_many :impresiones, :as => :imprimible
  has_many :impresiones_recs
  has_many :movimientos, :as => :documento, :class_name => "MovimientoCliente"


  def nombre
    "Recibo"
  end

  def anular
    if !self.anulada?
      if self.impresa?
        self.anulada = true
        @imprimio = true
        if self.manual
          @imp = self.impresiones_recs.where(:anulada => false)
        else
          @imp = self.impresiones.where(:anulada => false)
        end
        for i in @imp
          i.anulada = true
          i.save
        end

        if Setting.saldo_cc_independiente
          if (self.sucursal_id.nil?)


            for rr in self.renglon_recibos
              if !rr.factura.sucursal.nil?
                @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                @mov_suc_saldo = 0
                if !@mov_suc_id.nil?
                  @mov_suc = MovimientoCliente.find(@mov_suc_id)
                  @mov_suc_saldo = @mov_suc.saldo_sucursal
                end
                self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id ,:fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0,  :debe_sucursal => rr.total_renglon, :haber_sucursal => 0,:saldo_sucursal => @mov_suc_saldo + rr.total_renglon)
              else
                @mov = MovimientoCliente.find(self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id"))
                @total = self.total_sinimpuestos

                @mov_saldo = 0
                if !@mov.nil?
                  @mov_saldo = @mov.saldo
                end
                self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => rr.total_renglon, :haber => 0,:saldo => @mov_saldo + rr.total_renglon )
              end

            end

            for rr in self.renglon_recdetalles
              if !rr.factura.nil? and !rr.factura.sucursal.nil?

                @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                @mov_suc_saldo = 0
                if !@mov_suc_id.nil?
                  @mov_suc = MovimientoCliente.find(@mov_suc_id)
                  @mov_suc_saldo = @mov_suc.saldo_sucursal
                end
                self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0,  :debe_sucursal => rr.total_renglon, :haber_sucursal => 0,:saldo_sucursal => @mov_suc_saldo + rr.total_renglon)
              else
                @mov = MovimientoCliente.find(self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id"))
                @mov_saldo = 0
                if !@mov.nil?
                  @mov_saldo = @mov.saldo
                end
                self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => rr.total_renglon, :haber => 0,:saldo => @mov_saldo + rr.total_renglon )
              end
            end

            for rr in self.renglon_recibo_docs
              if !rr.documento.sucursal.nil?

                @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.documento.sucursal.id.to_s ).maximum("id")
                @mov_suc_saldo = 0
                if !@mov_suc_id.nil?
                  @mov_suc = MovimientoCliente.find(@mov_suc_id)
                  @mov_suc_saldo = @mov_suc.saldo_sucursal
                end
                self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id ,:sucursal_id => rr.documento.sucursal.id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0,  :debe_sucursal => rr.total_renglon, :haber_sucursal => 0,:saldo_sucursal => @mov_suc_saldo + rr.total_renglon)
              else
                @mov = MovimientoCliente.find(self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id"))
                @total = self.total_sinimpuestos
                @mov_saldo = 0
                if !@mov.nil?
                  @mov_saldo = @mov.saldo
                end
                self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => rr.total_renglon, :haber => 0,:saldo => @mov_saldo + rr.total_renglon )
              end

            end
          else
            @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ self.sucursal_id.to_s ).maximum("id")
            @total = self.total_sinimpuestos
            @mov_suc_saldo = 0
            if !@mov_suc_id.nil?
              @mov_suc = MovimientoCliente.find(@mov_suc_id)
              @mov_suc_saldo = @mov_suc.saldo_sucursal
            end
            self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id,:sucursal_id => self.sucursal.id , :fecha => Time.now.to_date.to_s, :sucursal_id => self.sucursal_id, :moneda_id => self.moneda_id, :debe =>0, :haber => 0,:saldo => 0, :debe_sucursal => @total , :haber_sucursal => 0,:saldo_sucursal => @mov_suc_saldo + @total)
          end
        else


          ##################################################################

          @mov = MovimientoCliente.find(self.comerciante.movimientos.where("moneda_id = "+ self.moneda_id.to_s).maximum("id"))
          @total = self.total_sinimpuestos
          @mov_saldo = 0
          if !@mov.nil?
            @mov_saldo = @mov.saldo
          end

          if (self.sucursal_id.nil?)

            #agrego los movimientos de sucursal para aquellos renglones que tengan sucursal.
            for rr in self.renglon_recibos
              if !rr.factura.sucursal.nil?

                @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                @mov_suc_saldo = 0
                if !@mov_suc_id.nil?
                  @mov_suc = MovimientoCliente.find(@mov_suc_id)
                  @mov_suc_saldo = @mov_suc.saldo_sucursal
                end
                self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id ,:fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => @mov_saldo,  :debe_sucursal => rr.total_renglon, :haber_sucursal => 0,:saldo_sucursal => @mov_suc_saldo + rr.total_renglon)
              end
            end


            for rr in self.renglon_recdetalles
              if !rr.factura.sucursal.nil?

                @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                @mov_suc_saldo = 0
                if !@mov_suc_id.nil?
                  @mov_suc = MovimientoCliente.find(@mov_suc_id)
                  @mov_suc_saldo = @mov_suc.saldo_sucursal
                end
                self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => @mov_saldo,  :debe_sucursal => rr.total_renglon, :haber_sucursal => 0,:saldo_sucursal => @mov_suc_saldo + rr.total_renglon)
              end
            end

            for rr in self.renglon_recibo_docs
              if !rr.documento.sucursal.nil?

                @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.documento.sucursal.id.to_s ).maximum("id")
                @mov_suc_saldo = 0
                if !@mov_suc_id.nil?
                  @mov_suc = MovimientoCliente.find(@mov_suc_id)
                  @mov_suc_saldo = @mov_suc.saldo_sucursal
                end
                self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id ,:sucursal_id => rr.documento.sucursal.id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => @mov_saldo,  :debe_sucursal => rr.total_renglon, :haber_sucursal => 0,:saldo_sucursal => @mov_suc_saldo + rr.total_renglon)
              end

            end
            self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s, :moneda_id => self.moneda_id, :debe => @total, :haber => 0,:saldo => @mov_saldo + @total)
          else
            @mov_suc = MovimientoCliente.find(self.comerciante.movimientos.where("moneda_id = "+ self.moneda_id.to_s + " and sucursal_id = "+ self.sucursal_id.to_s).maximum("id"))
            @mov_suc_saldo = 0
            if !@mov_suc.nil?
              @mov_suc_saldo = @mov_suc.saldo_sucursal
            end
            self.movimientos.create(:operacion => "Anulacion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s, :sucursal_id => self.sucursal_id, :moneda_id => self.moneda_id, :debe => @total, :haber => 0,:saldo => @mov_saldo + @total, :debe_sucursal => @total , :haber_sucursal => 0,:saldo_sucursal => @mov_suc_saldo + @total)
          end






          ##################################################################
        end

        if ! Setting.documentos_asociados
          for rr in self.renglon_recibo_docs
            rr.documento.imprimio = true
            rr.documento.adeudo += (rr.total_renglon)*self.moneda.tipodecambio/rr.documento.moneda.tipodecambio
            if !rr.documento.save
               return rr.documento.errors
            end
          end
        end

        for rr in self.renglon_recibos
          rr.factura.imprimio = true
          rr.factura.adeudo += (rr.total_renglon)*self.moneda.tipodecambio/rr.factura.moneda.tipodecambio
          if !rr.factura.save
             return rr.factura.errors
          end
        end

        for rd in self.renglon_recdetalles
          if !rd.factura.nil?
            rd.factura.imprimio = true
            rd.factura.adeudo += (rd.total_renglon )*self.moneda.tipodecambio/rd.factura.moneda.tipodecambio
            if !rd.factura.save
              #####################################################
              #####   ojo con estooooooooooooooooooo    ###########
              #####################################################

              puts "Salioooooooooooooo acaaaaaaaaaaa 2222"
              return rd.factura.errors
            end
          end
        end

      else
        errors.add(:anulada,"No puede anular un Recibo que no fue impreso.")
      end
    else
      errors.add(:anulada, "El Recibo ya fue anulado.")
    end

  end

  def imprimir(serie,numero)
    if (( !self.manual and !Impresione.exists?(:serie => serie, :numero => numero))||( self.manual and !ImpresionesRec.exists?(:serie => serie, :numero => numero)))
      if !self.anulada?
        @imprimio = true
        if self.valid?
          if self.impresa?
            if !self.manual
              @imp = self.impresiones.where(:anulada => "FALSE")
            else
              @imp = self.impresiones_recs.where(:anulada => "FALSE")
            end
            for i in @imp
              i.anulada = true
              i.save
            end
          else
            self.nom_moneda   = self.moneda.nombre
            self.tipo_de_cambio = self.moneda.tipodecambio
            if self.comerciante_type == "Cliente"

              if Setting.saldo_cc_independiente

                @total = self.total
                if self.sucursal_id.nil?

                  #agrego los movimientos de sucursal para aquellos renglones que tengan sucursal.
                  for rr in self.renglon_recibos
                    if !rr.factura.sucursal.nil?

                      @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                      @mov_suc_saldo = 0
                      if !@mov_suc_id.nil?
                        @mov_suc = MovimientoCliente.find(@mov_suc_id)
                        @mov_suc_saldo = @mov_suc.saldo_sucursal
                      end
                      self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0,  :debe_sucursal => 0, :haber_sucursal => rr.total_renglon,:saldo_sucursal => @mov_suc_saldo - rr.total_renglon)
                    else
                      @mov = MovimientoCliente.find(self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id"))
                      @mov_saldo = 0
                      if !@mov.nil?
                        @mov_saldo = @mov.saldo
                      end

                      self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => rr.total_renglon,:saldo => @mov_saldo - rr.total_renglon)
                    end

                  end


                  for rr in self.renglon_recdetalles
                    if !rr.factura.nil? and !rr.factura.sucursal.nil?

                      @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                      @mov_suc_saldo = 0
                      if !@mov_suc_id.nil?
                        @mov_suc = MovimientoCliente.find(@mov_suc_id)
                        @mov_suc_saldo = @mov_suc.saldo_sucursal
                      end
                      self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0,  :debe_sucursal => 0, :haber_sucursal => rr.total_renglon,:saldo_sucursal => @mov_suc_saldo - rr.total_renglon)
                    else
                      ##############
                      #######     no se por que no entra.
                      #############
                      @mov = MovimientoCliente.find(self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id"))
                      @mov_saldo = 0
                      if !@mov.nil?
                        @mov_saldo = @mov.saldo
                      end

                      self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => rr.total_renglon,:saldo => @mov_saldo - rr.total_renglon)
                    end
                  end

                  for rr in self.renglon_recibo_docs
                    if !rr.documento.sucursal.nil?

                      @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.documento.sucursal.id.to_s ).maximum("id")
                      @mov_suc_saldo = 0
                      if !@mov_suc_id.nil?
                        @mov_suc = MovimientoCliente.find(@mov_suc_id)
                        @mov_suc_saldo = @mov_suc.saldo_sucursal
                      end
                      self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :sucursal_id => rr.documento.sucursal.id , :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0,  :debe_sucursal => 0, :haber_sucursal => rr.total_renglon,:saldo_sucursal => @mov_suc_saldo - rr.total_renglon)
                    else
                      @mov = MovimientoCliente.find(self.comerciante.movimientos.where("sucursal_id IS NULL and moneda_id = "+ self.moneda_id.to_s).maximum("id"))
                      @mov_saldo = 0
                      if !@mov.nil?
                        @mov_saldo = @mov.saldo
                      end

                      self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => rr.total_renglon,:saldo => @mov_saldo - rr.total_renglon)
                    end

                  end
                else
                  @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ self.sucursal_id.to_s ).maximum("id")
                  @mov_suc_saldo = 0
                  if !@mov_suc_id.nil?
                    @mov_suc = MovimientoCliente.find(@mov_suc_id)
                    @mov_suc_saldo = @mov_suc.saldo_sucursal
                  end
                  self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :sucursal_id => self.sucursal.id , :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => 0,  :debe_sucursal => 0, :haber_sucursal => @total,:saldo_sucursal => @mov_suc_saldo - @total)
                end
              else

                ##########################################################################

                @total = self.total

                @mov_id = self.comerciante.movimientos.where("moneda_id = "+ self.moneda_id.to_s).maximum("id")
                @mov_saldo = 0
                if !@mov_id.nil?
                  @mov = MovimientoCliente.find( @mov_id )
                  @mov_saldo = @mov.saldo
                end
                if self.sucursal_id.nil?

                  #agrego los movimientos de sucursal para aquellos renglones que tengan sucursal.
                  for rr in self.renglon_recibos
                    if !rr.factura.sucursal.nil?

                      @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                      @mov_suc_saldo = 0
                      if !@mov_suc_id.nil?
                        @mov_suc = MovimientoCliente.find(@mov_suc_id)
                        @mov_suc_saldo = @mov_suc.saldo_sucursal
                      end
                      self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => @mov_saldo,  :debe_sucursal => 0, :haber_sucursal => rr.total_renglon,:saldo_sucursal => @mov_suc_saldo - rr.total_renglon)
                    end

                  end


                  for rr in self.renglon_recdetalles
                    if !rr.factura.sucursal.nil?

                      @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.factura.sucursal.id.to_s ).maximum("id")
                      @mov_suc_saldo = 0
                      if !@mov_suc_id.nil?
                        @mov_suc = MovimientoCliente.find(@mov_suc_id)
                        @mov_suc_saldo = @mov_suc.saldo_sucursal
                      end
                      self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id,:sucursal_id => rr.factura.sucursal.id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => @mov_saldo,  :debe_sucursal => 0, :haber_sucursal => rr.total_renglon,:saldo_sucursal => @mov_suc_saldo - rr.total_renglon)

                    end

                  end

                  for rr in self.renglon_recibo_docs
                    if !rr.documento.sucursal.nil?

                      @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ rr.documento.sucursal.id.to_s ).maximum("id")
                      @mov_suc_saldo = 0
                      if !@mov_suc_id.nil?
                        @mov_suc = MovimientoCliente.find(@mov_suc_id)
                        @mov_suc_saldo = @mov_suc.saldo_sucursal
                      end
                      self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :sucursal_id => rr.documento.sucursal.id , :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => 0,:saldo => @mov_saldo,  :debe_sucursal => 0, :haber_sucursal => rr.total_renglon,:saldo_sucursal => @mov_suc_saldo - rr.total_renglon)
                    end
                  end

                  self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => @total,:saldo => @mov_saldo - @total)
                else
                  @mov_suc_id = self.comerciante.movimientos.where("moneda_id = "+self.moneda_id.to_s+" and sucursal_id = "+ self.sucursal_id.to_s ).maximum("id")
                  @mov_suc_saldo = 0
                  if !@mov_suc_id.nil?
                    @mov_suc = MovimientoCliente.find(@mov_suc_id)
                    @mov_suc_saldo = @mov_suc.saldo_sucursal
                  end

                  self.movimientos.create(:operacion => "Impresion", :cliente_id => self.comerciante_id, :sucursal_id => self.sucursal.id , :fecha => Time.now.to_date.to_s , :moneda_id => self.moneda_id, :debe => 0, :haber => @total,:saldo => @mov_saldo - @total,  :debe_sucursal => 0, :haber_sucursal => @total,:saldo_sucursal => @mov_suc_saldo - @total)
                end




              end


            end  ####################################################################






            for rr in self.renglon_recibos
              rr.factura.imprimio = true
              #rr.factura.adeudo -= (rr.total_renglon + rr.total_impuestos )*self.moneda.tipodecambio/rr.factura.moneda.tipodecambio
              if !rr.factura.save
                #####################################################
                #####   ojo con estooooooooooooooooooo    ###########
                #####################################################
                 return rr.factura.errors
              end
            end
            for rd in self.renglon_recdetalles
              #for imp in rd.impuestos
              #  @fi = rd.foto_impuesto_recs.create(:nombre => imp.nombre, :porcentaje => imp.porcentajea)
              #  @fi.save
              #end
              if !rd.factura.nil?
                rd.factura.imprimio = true
                #rd.factura.adeudo -= (rd.total_renglon + rd.total_impuestos )*(self.moneda.tipodecambio/rd.factura.moneda.tipodecambio)
                if !rd.factura.save!
                  #####################################################
                  #####   ojo con estooooooooooooooooooo    ###########
                  #####################################################

                  puts "Salioooooooooooooo acaaaaaaaaaaa"
                  return rd.factura.errors
                end
              end
            end

            for rds in self.renglon_recibo_docs
              rds.documento.imprimio = true
              rds.documento.save
            end

          end
          if self.manual
            self.impresiones_recs.create(:serie => serie, :numero => numero,:anulada => false)
          else
            self.impresiones.create(:serie => serie, :numero => numero,:anulada => false, :cant_paginas => self.cant_paginas)
          end
          if !self.impresa
            self.asignar_numero
            self.impresa = true
          end
        end
      else
        errors.add(:anulada, "El Recibo se encuentra anulado.")
      end
    else
      if !self.impresa
       errors.add(:impresiones,"El par  serie-numero pre-impreso ya fue utilizado.")
      end
    end
  end

  def total_sinimpuestos
    @total = 0

    if Setting.documentos_asociados
      @total += self.renglon_recibos.sum(:total_renglon)
      @total += self.renglon_recdetalles.sum(:total_renglon)
    else
      @total += self.renglon_recibo_docs.sum(:total_renglon)
      @total += self.renglon_recibos.sum(:total_renglon)
      @total += self.renglon_recdetalles.sum(:total_renglon)
    end

    @total.round(2)
  end

  #def total_impuestos
  #  @total = 0
  #  if Setting.documentos_asociados
  #    @total += self.renglon_recibos.sum(:total_impuestos)
  #    @total += self.renglon_recdetalles.sum(:total_impuestos)
  #  else
  #   # @total += self.renglon_ndc_articulos.sum(:total_impuestos)
  #    @total += self.renglon_recdetalles.sum(:total_impuestos)
  #  end
  #  @total
  #end

  def total
    @total = self.total_sinimpuestos
  end

  def asignar_numero
    Recibo.transaction do

      @rec_ant = Recibo.where("impresa = 1").order("numero DESC").first
      if !@rec_ant.nil?
        self.numero = @rec_ant.numero.next
      else
        self.numero = "A00001"
      end
    end
  end

  def cant_paginas
    @cant_renglones = self.renglon_recibos.size + self.renglon_recibo_docs.size + self.renglon_recdetalles.size
    (@cant_renglones / Setting.renglones_por_hoja) + (( @cant_renglones % Setting.renglones_por_hoja > 0 ) ? 1 : 0)
  end


  private



  validates :pagocontado_id, :presence => {:message => "Debe ingresar una Forma de Pago Contado."}
  validates :fecha, :presence => {:message => "Debe ingresar una Fecha."}
  #validates :cliente_id, :presence => {:message => "Debe ingresar un Nombre."}
  #validate :comerciante_val
  validate :asociarfacturaodetalle
  validate :impresa_val
  validate :moneda_val
  validate :anulada_val
  validate :anulada_impresa_val
  validate :adeudo_val

  before_destroy :destroy_val?
  after_create :cargar_renglones

  def cargar_renglones
    if Setting.generar_renglon_recibo
      if self.sucursal.nil?
        @cond = ' and ( sucursal_id IS NULL )'
        if self.con_suc == "true"
          @cond = ''
        end
      else
        @cond = 'and (sucursal_id = ' + self.sucursal.id.to_s + ')'
      end
      if self.desde.nil?
        self.desde = Time.now.to_date
      end

      if self.hasta.nil?
        self.hasta = Time.now.to_date
      end

      for fact in self.comerciante.facturas.where("adeudo >= 1 and impresa = 1 and anulada = 0 and fecha >= ? and fecha <= ? " + @cond ,self.desde,self.hasta)

        @renglon_recibo_doc = fact.renglon_recibo_docs.build(:recibo_id => self.id, :total_renglon => fact.adeudo)
        @renglon_recibo_doc.save
      end


      if !Setting.documentos_asociados

        for notadc in self.comerciante.notadecreditos.where("es_devolucion = 0 and adeudo <= -1 and impresa = 1 and anulada = 0 and fecha >= ? and fecha <= ? "+ @cond ,self.desde,self.hasta)
          @renglon_recibo_doc = notadc.renglon_recibo_docs.build(:recibo_id => self.id, :total_renglon => notadc.adeudo)
          @renglon_recibo_doc.save
        end


        if Setting.usar_notadd

        end

      end
    end
  end

  def destroy_val?
    errors.add(:impresa, "No puede modificar un Recibo impresa.") if self.impresa?
    errors.blank?
  end


  def anulada_val
    errors.add(:anulada,"No puede modificar un Recibo anulado.") if !(@imprimio == true) and self.anulada?
  end


  def anulada_impresa_val
    errors.add(:anulada,"No puede anular un Recibo no impreso.") if !self.impresa? and self.anulada?
  end

  def moneda_val
    errors.add(:moneda, "Debe seleccionar una moneda.") if self.moneda.nil?
    errors.add(:moneda,"La moneda seleccionada no forma parte del Pago Contado.") if !self.pagocontado.nil? and !self.moneda.nil? and !self.pagocontado.moneda.exists?(self.moneda.id)
  end


  def impresa_val
    errors.add(:impresa,"No puede modificar un Recibo impreso.") if !(@imprimio == true) and self.impresa?
  end

  #def comerciante_val
  #  errors.add(:comerciante,"El cliente no dispone de Facturas a Credito pendientes.") if self.comerciante.facturas.where("adeudo > 0").empty?
  #end

  def asociarfacturaodetalle
    #errors.add(:pagocontado,"Debe asociar alguna Factura o Detalle en el Recibo.") if !self.id.nil? and self.renglon_recibos.empty? and self.renglon_recdetalles.empty?
  end

  def adeudo_val
    if !self.impresa?
      if Setting.documentos_asociados

        for rr in self.renglon_recibos
            rr.factura.imprimio = true
            rr.factura.adeudo -= (rr.total )*self.moneda.tipodecambio/rr.factura.moneda.tipodecambio

            @rds = self.renglon_recdetalles.where(:factura_id => rr.factura.id)
            if !@rds.nil?
              for rdet in @rds
                rr.factura.adeudo -= (rdet.total )*self.moneda.tipodecambio/rdet.factura.moneda.tipodecambio
              end
            end

            if !rr.factura.valid?
              #####################################################
              #####   ojo con estooooooooooooooooooo    ###########
              #####################################################
              #puts "entroooooooo acaaa"
              #puts  rr.factura.errors.get(:adeudo)
              self.errors[:impresa] << rr.factura.errors.get(:adeudo)[0]
              #self.errors.blank?
            end
        end
        for rd in self.renglon_recdetalles
          if self.renglon_recibos.empty? || self.renglon_recibos.find_by_factura_id(rd.factura.id).nil?
            rd.factura.adeudo -= (rd.total_renglon )*self.moneda.tipodecambio/rd.factura.moneda.tipodecambio
          end
        end
      else
        for rr in self.renglon_recibo_docs
          rr.documento.imprimio = true
          rr.documento.adeudo -= (rr.total_renglon)*self.moneda.tipodecambio/rr.documento.moneda.tipodecambio
          if rr.documento.class.name == "Factura"
            @rds = self.renglon_recdetalles.where(:factura_id => rr.documento.id)
            if !@rds.nil?
              for rdet in @rds
                rr.documento.adeudo -= (rdet.total_renglon )*self.moneda.tipodecambio/rdet.factura.moneda.tipodecambio
              end
            end
          end

          if !rr.documento.valid?
            #####################################################
            #####   ojo con estooooooooooooooooooo    ###########
            #####################################################
            #puts "entroooooooo acaaa"
            #puts  rr.factura.errors.get(:adeudo)
            self.errors[:impresa] << rr.documento.errors.get(:adeudo)[0]
            #self.errors.blank?
          end
        end
        for rd in self.renglon_recdetalles
          ###################################################
          ######################################################
          ##########   REVISAR ESTOOOOO
          ###################################################
          ######################################################

          if self.renglon_recibo_docs.empty? || (!rd.factura.nil? and self.renglon_recibo_docs.where(:documento_id => rd.factura.id,:documento_type => rd.factura.class.name).empty?)
            rd.factura.adeudo -= (rd.total_renglon )*self.moneda.tipodecambio/rd.factura.moneda.tipodecambio
            if !rd.factura.valid?
              self.errors[:impresa] << rr.factura.errors.get(:adeudo)[0]
            end
          end
        end
      end
    end
  end
end
