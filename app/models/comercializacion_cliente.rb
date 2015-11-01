# encoding: utf-8
  require 'axlsx'

  class ComercializacionCliente

    def self.titulos(facturas, credito, recibos, ndcs, ndvs, ndds, factws, factcdws, recws, ndcws, ndvws, nddws, totalws, msg, title)
      if facturas == "true"
        factws.add_row [msg+ " - Boletas Contado - Generado: " + Time.now.to_date.to_s], :style => title
        #factws.merge_cells 'A1:I1'
      end
      if credito == "true"
        factcdws.add_row [msg+ " - Facturas Crédito - Generado: " + Time.now.to_date.to_s], :style => title
        #factcdws.merge_cells 'A1:I1'
      end
      if recibos == "true"
        recws.add_row [msg+ " - Recibos - Generado: " + Time.now.to_date.to_s], :style => title
        #recws.merge_cells 'A1:F1'
      end
      if ndcs == "true"
        ndcws.add_row [msg+ " - Notas de Crédito - Generado: " + Time.now.to_date.to_s], :style => title
        #ndcws.merge_cells 'A1:H1'
      end
      if ndvs == "true"
        ndvws.add_row [msg+ " - Notas de Devolución - Generado: " + Time.now.to_date.to_s], :style => title
        #ndvws.merge_cells 'A1:H1'
      end
      if Setting.usar_notadd
        if ndds == "true"
          nddws.add_row [msg+ " - Notas de Débito - Generado: " + Time.now.to_date.to_s], :style => title
          #nddws.merge_cells 'A1:H1'
        end
      end

      if (Setting.usar_notadd and (credito == "true" and ndcs == "true" and ndds == "true") or (facturas =="true" and ndvs == "true")) or (!Setting.usar_notadd and (credito == "true" and ndcs == "true")or (facturas =="true" and ndvs == "true"))
        totalws.add_row [""]
        totalws.add_row ["", "Totales Boletas contado","","","","Totales Notas de Devolución","","","","Totales [Total Boletas Contado - total Notas de Devolución]"], :style => title
        totalws.merge_cells 'B2:D2'
        totalws.merge_cells 'F2:H2'
        totalws.merge_cells 'J2:L2'
      end

    end



    def self.emision(grupo_id, cliente_id, sucursal_id, insucursal ,inicio, fin, facturas, credito ,pendientes, vencidas, recibos, ndcs, ndvs, ndds , anulada)
      @condicion = " ( impresa = 1"
      if (anulada == "true")
        @condicion += ' or anulada = 1)'
      else
        @condicion += ' and anulada = 0)'
      end

      # 0 suma el total impuestos (total_impuestos) y 1 re-calcula con los foto_impuestos (total_impuestos_discriminado)
      @calculo_impuestos = 1

      @formtot = []
      @formtot[0] = "=" # totales de contado
      @formtot[1] = "=" # totales de crédito
      @formtot[2] = "=" # totales de notas devolución
      @formtot[3] = "=" # totales de notas de crédito
      @formtot[4] = "=" # totales de notas de débito

      @impuestos = Impuesto.uniq.pluck(:nombre)

      p = Axlsx::Package.new
      p.workbook do |wb|


        title = wb.styles.add_style(:sz => 5, :b => true, :u => true, :wrap_text => true)
        default = wb.styles.add_style(:sz => 15, :border => Axlsx::STYLE_THIN_BORDER, :wrap_text => true, :num_fmt => 1)
        header = wb.styles.add_style(:sz => 5, :bg_color => '3399FF', :b => true, :wrap_text => true)
        money = wb.styles.add_style(:sz => 15, :format_code => '#,###,##0.00', :border => Axlsx::STYLE_THIN_BORDER, :wrap_text => true)

        if facturas == "true"
          factws =  wb.add_worksheet(:name => 'Contado')
          factws.sheet_view.pane do |pane|
            pane.top_left_cell = "A6"
            pane.state = :frozen_split
            pane.y_split = 5
            pane.x_split = 0
            pane.active_pane = :bottom_right
          end
        end
        if credito == "true"
          factcdws =  wb.add_worksheet(:name => 'Crédito')
          factcdws.sheet_view.pane do |pane|
            pane.top_left_cell = "A6"
            pane.state = :frozen_split
            pane.y_split = 5
            pane.x_split = 0
            pane.active_pane = :bottom_right
          end
        end
        if recibos == "true"
          recws = wb.add_worksheet(:name => 'Recibos')
          recws.sheet_view.pane do |pane|
            pane.top_left_cell = "A6"
            pane.state = :frozen_split
            pane.y_split = 5
            pane.x_split = 0
            pane.active_pane = :bottom_right
          end
        end
        if ndcs == "true"
          ndcws = wb.add_worksheet(:name => 'Notas de Crédito')
          ndcws.sheet_view.pane do |pane|
            pane.top_left_cell = "A6"
            pane.state = :frozen_split
            pane.y_split = 5
            pane.x_split = 0
            pane.active_pane = :bottom_right
          end
        end
        if ndvs == "true"
          ndvws = wb.add_worksheet(:name => 'Notas de Devolución')
          ndvws.column_widths 10, 15, 10, 20, 5, 5, 15, 15, 15, 15, 15
          ndvws.sheet_view.pane do |pane|
            pane.top_left_cell = "A6"
            pane.state = :frozen_split
            pane.y_split = 5
            pane.x_split = 0
            pane.active_pane = :bottom_right
          end
        end
        if Setting.usar_notadd
          if ndds == "true"
            nddws = wb.add_worksheet(:name => 'Notas de Débito')
            nddws.column_widths 10, 15, 10, 20, 5, 5, 15, 15, 15, 15, 15
            nddws.sheet_view.pane do |pane|
              pane.top_left_cell = "A6"
              pane.state = :frozen_split
              pane.y_split = 5
              pane.x_split = 0
              pane.active_pane = :bottom_right
            end
          end
          if (credito == "true" and ndcs == "true" and ndds == "true") or (facturas =="true" and ndvs == "true")
            totalws = wb.add_worksheet(:name => 'Totales')
            totalws.column_widths 10, 5, 15, 15, 15, 5, 15, 15, 15, 5, 15, 15, 15
          end
        else
          if (credito == "true" and ndcs == "true") or (facturas =="true" and ndvs == "true")
            totalws = wb.add_worksheet(:name => 'Totales')
            totalws.column_widths 5, 15, 15, 15, 5, 15, 15, 15, 5, 15, 15, 15, 15, 15, 15, 15, 15, 15
          end
        end


        @iterfact = 2
        @iterfactcd = 2
        @iterrec = 2
        @iterndc = 2
        @iterndd = 2
        @iterndv = 2
        @itertotal = 2


        if grupo_id.nil?
          if cliente_id.nil?

            @msg = "Emisión Cliente : Todos - Por fecha"
            titulos(facturas, credito, recibos, ndcs, ndvs, ndds, factws, factcdws, recws, ndcws, ndvws, nddws, totalws, @msg, title)

            emision_cliente(nil,sucursal_id, insucursal,inicio, fin, facturas, credito,pendientes, vencidas,recibos,ndcs, ndvs,ndds, factws, factcdws,recws,ndcws,ndvws,nddws, totalws,@condicion, @iterfact, @iterfactcd, @iterrec, @iterndc,@iterndv, @iterndd, @itertotal, title, default, header, money, @formtot)
          elsif cliente_id == '0'
            @msg = "Emisión Cliente : Todos - Por Cliente"
            titulos(facturas, credito, recibos, ndcs, ndvs, ndds, factws, factcdws, recws, ndcws, ndvws, nddws, totalws, @msg, title)

            for cl in Cliente.all

              emision_cliente(cl,sucursal_id, insucursal,inicio, fin, facturas, credito,pendientes, vencidas,recibos,ndcs, ndvs,ndds, factws, factcdws,recws,ndcws,ndvws,nddws, totalws,@condicion, @iterfact, @iterfactcd, @iterrec, @iterndc,@iterndv, @iterndd, @itertotal, title, default, header, money, @formtot)
            end
          elsif cliente_id.to_i > 0
            @msg = "Emisión Cliente : De un Cliente - Por Fecha"
            titulos(facturas, credito, recibos, ndcs, ndvs, ndds, factws, factcdws, recws, ndcws, ndvws, nddws, totalws, @msg, title)

            @cliente = Cliente.find(cliente_id)
            emision_cliente(@cliente,sucursal_id, insucursal,inicio, fin, facturas, credito,pendientes, vencidas,recibos,ndcs, ndvs,ndds, factws, factcdws,recws,ndcws,ndvws,nddws, totalws,@condicion, @iterfact, @iterfactcd, @iterrec, @iterndc,@iterndv, @iterndd, @itertotal, title, default, header, money, @formtot)
          end
        elsif grupo_id == '0'

          @msg = "Emisión Cliente : Todos - Por Grupo"
          titulos(facturas, credito, recibos, ndcs, ndvs, ndds, factws, factcdws, recws, ndcws, ndvws, nddws, totalws, @msg, title)


          for gr in Tipocliente.all

              @titulo = gr.nombre


              if facturas == "true"
                factws.add_row [@titulo], :style => title
                factws.merge_cells 'A'+@iterfact.to_s+':D'+@iterfact.to_s
                @iterfact += 1
              end
              if credito == "true"
                factcdws.add_row [@titulo], :style => title
                factcdws.merge_cells 'A'+@iterfactcd.to_s+':D'+@iterfactcd.to_s
                @iterfactcd += 1
              end
              if recibos == "true"
                recws.add_row [@titulo], :style => title
                recws.merge_cells 'A'+@iterrec.to_s+':D'+@iterrec.to_s
                @iterrec += 1
              end
              if ndcs == "true"
                ndcws.add_row [@titulo], :style => title
                ndcws.merge_cells 'A'+@iterndc.to_s+':D'+@iterndc.to_s
                @iterndc += 1
              end
              if ndvs == "true"
                ndvws.add_row [@titulo], :style => title
                ndvws.merge_cells 'A'+@iterndv.to_s+':D'+@iterndv.to_s
                @iterndv += 1
              end
              if Setting.usar_notadd
                if ndds == "true"
                  nddws.add_row [@titulo], :style => title
                  nddws.merge_cells 'A'+@iterndd.to_s+':D'+@iterndd.to_s
                  @iterndd += 1
                end
              end


            if cliente_id == '0'
              for cliente in gr.cliente
                emision_cliente(cliente,sucursal_id, insucursal,inicio, fin, facturas, credito,pendientes, vencidas,recibos,ndcs, ndvs,ndds, factws,factcdws,recws,ndcws,ndvws,nddws, totalws,@condicion, @iterfact, @iterfactcd, @iterrec, @iterndc,@iterndv, @iterndd, @itertotal, title, default, header, money, @formtot)
              end
            else
              @idscond = "and ( comerciante_id in ("
              @hay_cl = false
              for cliente in gr.cliente
                if @hay_cl
                  @idscond += "," + cliente.id.to_s
                else
                   @hay_cl = true
                   @idscond += cliente.id.to_s
                end
              end
              @idscond += ") )"
              @condicion += (@hay_cl ? @idscond : "")
              emision_cliente(nil,sucursal_id, insucursal,inicio, fin, facturas, credito,pendientes, vencidas,recibos,ndcs, ndvs,ndds, factws,factcdws,recws,ndcws,ndvws,nddws, totalws,@condicion, @iterfact, @iterfactcd, @iterrec, @iterndc,@iterndv, @iterndd, @itertotal, title, default, header, money, @formtot)
            end
          end
        elsif grupo_id.to_i > 0
          @msg = "Emisión Cliente : Todos - De un Grupo"

          @gr = Tipocliente.find(grupo_id)
          @titulo = @gr.nombre
          if facturas == "true"
            factws.add_row [@msg+ " - Boletas Contado - Generado: " + Time.now.to_date.to_s], :style => title
            factws.merge_cells 'A1:I1'
            factws.add_row [@titulo], :style => title
            factws.merge_cells 'A'+@iterfact.to_s+':D'+@iterfact.to_s
            @iterfact += 1
          end
          if credito == "true"
            factcdws.add_row [@msg+ " - Facturas Crédito - Generado: " + Time.now.to_date.to_s], :style => title
            factcdws.merge_cells 'A1:I1'
            factcdws.add_row [@titulo], :style => title
            factcdws.merge_cells 'A'+@iterfactcd.to_s+':D'+@iterfactcd.to_s
            @iterfactcd += 1
          end
          if recibos == "true"
            recws.add_row [@msg+ " - Recibos - Generado: " + Time.now.to_date.to_s], :style => title
            recws.merge_cells 'A1:F1'
            recws.add_row [@titulo], :style => title
            recws.merge_cells 'A'+@iterrec.to_s+':D'+@iterrec.to_s
            @iterrec += 1
          end
          if ndcs == "true"
            ndcws.add_row [@msg+ " - Notas de Crédito - Generado: " + Time.now.to_date.to_s], :style => title
            ndcws.merge_cells 'A1:H1'
            ndcws.add_row [@titulo], :style => title
            ndcws.merge_cells 'A'+@iterndc.to_s+':D'+@iterndc.to_s
            @iterndc += 1
          end
          if ndvs == "true"
            ndvws.add_row [@msg+ " - Notas de Devolución - Generado: " + Time.now.to_date.to_s], :style => title
            ndvws.merge_cells 'A1:H1'
            ndvws.add_row [@titulo], :style => title
            ndvws.merge_cells 'A'+@iterndv.to_s+':D'+@iterndv.to_s
            @iterndv += 1
          end
          if Setting.usar_notadd
            if ndds == "true"
              nddws.add_row [@msg+ " - Notas de Débito - Generado: " + Time.now.to_date.to_s], :style => title
              nddws.merge_cells 'A1:H1'
              nddws.add_row [@titulo], :style => title
              nddws.merge_cells 'A'+@iterndd.to_s+':D'+@iterndd.to_s
              @iterndd += 1
            end
          end
          if (Setting.usar_notadd and (credito == "true" and ndcs == "true" and ndds == "true") or (facturas =="true" and ndvs == "true")) or (!Setting.usar_notadd and (credito == "true" and ndcs == "true")or (facturas =="true" and ndvs == "true")) then
            totalws.add_row [""]
            totalws.add_row ["", "Totales Boletas contado","","","","Totales Notas de Devolución","","","","Totales [Total Boletas Contado - total Notas de Devolución]"], :style => title
            totalws.merge_cells 'B2:D2'
            totalws.merge_cells 'F2:H2'
            totalws.merge_cells 'J2:L2'
          end

          for cliente in @gr.cliente
            emision_cliente(cliente,sucursal_id, insucursal ,inicio, fin, facturas, credito,pendientes, vencidas,recibos,ndcs, ndvs,ndds, factws, factcdws,recws,ndcws,ndvws,nddws, totalws,@condicion, @iterfact, @iterfactcd, @iterrec, @iterndc,@iterndv, @iterndd, @itertotal, title, default, header, money, @formtot)
          end
        end

        #Carga de ws de totales
        if (Setting.usar_notadd and ((credito == "true" and ndcs == "true" and ndds == "true") or (facturas =="true" and ndvs == "true")))
          #not implemented yet
        elsif (!Setting.usar_notadd and (credito == "true" and ndcs == "true") or (facturas =="true" and ndvs == "true")) then
          totalws.add_row ["", "Total s/impuestos", "Total impuestos", "Total", "", "Total s/impuestos", "Total impuestos", "Total", "", "Total s/impuestos", "Total impuestos", "Total"], :style => [title, header, header, header, title, header, header, header, title, header, header, header]

          #Rails.logger.debug(@formtot)

          @formtotAux = ["", "", "", ""]
          @formtotAux[0] << @formtot[0]
          @formtotAux[1] << @formtot[0]
          @formtotAux[2] << @formtot[2]
          @formtotAux[3] << @formtot[2]

          #Con esto del sub! sustituyo la primer ocurrecia de !G po !H iterando sustituyo todas, así creo las 3 formulas.
          @letra = "J"
          @letra2 = "I"
          for impu in @impuestos
            @letra = @letra.next
            @letra2 = @letra2.next
          end

          @cond = ""
          while  @cond != nil do @cond = @formtotAux[0].sub! '!I', '!'+@letra end

          @cond = ""
          while  @cond != nil do @cond = @formtotAux[1].sub! '!I', '!'+@letra.next end

          @cond = ""
          while  @cond != nil do @cond = @formtotAux[2].sub! '!H', '!'+@letra2 end

          @cond = ""
          while  @cond != nil do @cond = @formtotAux[3].sub! '!H', '!'+@letra2.next end

          totalws.add_row ["", @formtot[0], @formtotAux[0], @formtotAux[1], "", @formtot[2], @formtotAux[2], @formtotAux[3], "", "=B4-F4", "=C4-G4", "=D4-H4"], :style => [title, money, money, money, title, money, money, money, title, money, money, money]

          totalws.add_row [""]
          totalws.add_row ["", "Totales Facturas Crédito","","","","Totales Notas de Crédito","","","","Totales [Total Facturas Crédito - total Notas de Crédito]"], :style => title
          totalws.merge_cells 'B6:D6'
          totalws.merge_cells 'F6:H6'
          totalws.merge_cells 'J6:L6'

          totalws.add_row ["", "Total s/impuestos", "Total impuestos", "Total", "", "Total s/impuestos", "Total impuestos", "Total", "", "Total s/impuestos", "Total impuestos", "Total"], :style => [title, header, header, header, title, header, header, header, title, header, header, header]

          @formtotAux = ["", "", "", ""]
          @formtotAux[0] << @formtot[1]
          @formtotAux[1] << @formtot[1]
          @formtotAux[2] << @formtot[3]
          @formtotAux[3] << @formtot[3]

          @letra = "J"
          @letra2 = "I"
          for impu in @impuestos
            @letra = @letra.next
            @letra2 = @letra2.next
          end

          @cond = ""
          while  @cond != nil do @cond = @formtotAux[0].sub! '!I', '!'+@letra end

          @cond = ""
          while  @cond != nil do @cond = @formtotAux[1].sub! '!I', '!'+@letra.next end

          @cond = ""
          while  @cond != nil do @cond = @formtotAux[2].sub! '!H', '!'+@letra2 end

          @cond = ""
          while  @cond != nil do @cond = @formtotAux[3].sub! '!H', '!'+@letra2.next end

          totalws.add_row ["", @formtot[1], @formtotAux[0], @formtotAux[1], "", @formtot[3], @formtotAux[2], @formtotAux[3], "", "=B8-F8", "=C8-G8", "=D8-H8"], :style => [title, money, money, money, title, money, money, money, title, money, money, money]

        end

        if facturas == "true"
          factws.column_widths 10, 10, 12, 32, 15, 12, 10, 12, 15, 15, 15, 15, 15, 15
        end
        if credito == "true"
          factcdws.column_widths 10, 10, 12, 32, 15, 12, 10, 12, 15, 15, 15, 15, 15, 15
        end
        if recibos == "true"
          recws.column_widths 10, 15, 35, 15, 15, 15, 15
        end
        if ndcs == "true"
          ndcws.column_widths 10, 10, 12, 32, 15, 12, 10, 15, 15, 15, 15, 15, 15, 15
        end
        if ndvs == "true"
          ndvws.column_widths 10, 10, 12, 32, 15, 12, 10, 15, 15, 15, 15, 15, 15, 15
        end


      end

      return p

    end

    def self.movimientos( grupo_id, cliente_id, sucursal_id, insucursal, monedas, a_la_fecha, desde_la_fecha )
      p = Axlsx::Package.new
        p.workbook do |wb|

          title = wb.styles.add_style(:sz => 5, :b => true, :u => true)
          default = wb.styles.add_style(:border => Axlsx::STYLE_THIN_BORDER)
          header = wb.styles.add_style(:bg_color => '3399FF', :b => true)
          money = wb.styles.add_style(:format_code => '#,###,##0.00', :border => Axlsx::STYLE_THIN_BORDER)


          movws =  wb.add_worksheet(:name => 'Movimientos')
          movws.sheet_view.pane do |pane|
            pane.top_left_cell = "A6"
            pane.state = :frozen_split
            pane.y_split = 5
            pane.x_split = 0
            pane.active_pane = :bottom_right
          end

          grafsws =  wb.add_worksheet(:name => 'Gráficas')
          grafsws.add_row [""], :style => title
          grafsws.add_row ["", "Próximamente..."], :style => title

          @iter = 2

          if grupo_id.nil?
            if cliente_id.nil?
              if sucursal_id.nil?
                movws.add_row ["Movimientos de Cuentas","Por fecha", "Generado :" + Time.now.to_date.to_s], :style => title
                movws.merge_cells 'A1:I1'
                @sucursal = Sucursal.find(sucursal_id)
                monedas.split(",").collect{ |s| s.to_i }.each do |moneda_id|
                  movimientos_cliente(@sucursal.empresa,sucursal_id, insucursal, moneda_id, a_la_fecha, desde_la_fecha , movws, @iter,  title, default, header, money)
                end
              elsif sucursal_id.to_i == 0
                movws.add_row ["Movimientos de Cuentas","Por sucursal", "Generado :" + Time.now.to_date.to_s], :style => title
                movws.merge_cells 'A1:I1'
                monedas.split(",").collect{ |s| s.to_i }.each do |moneda_id|
                  movimientos_cliente(nil,sucursal_id, insucursal, moneda_id, a_la_fecha, desde_la_fecha , movws, @iter,  title, default, header, money)
                end
              elsif sucursal_id.to_i > 0
                movws.add_row ["Movimientos de Cuentas","Por fecha", "Generado :" + Time.now.to_date.to_s], :style => title
                movws.merge_cells 'A1:I1'
                @sucursal = Sucursal.find(sucursal_id)
                monedas.split(",").collect{ |s| s.to_i }.each do |moneda_id|
                  movimientos_cliente(@sucursal.empresa,sucursal_id, insucursal, moneda_id, a_la_fecha, desde_la_fecha , movws, @iter,  title, default, header, money)
                end
              end
            elsif cliente_id == '0'
              movws.add_row ["Movimientos de Cuentas","Por cliente", "Generado :" + Time.now.to_date.to_s], :style => title
              movws.merge_cells 'A1:I1'
              for cliente in Cliente.all
                monedas.split(",").collect{ |s| s.to_i }.each do |moneda_id|
                  movimientos_cliente(cliente,sucursal_id, insucursal, moneda_id, a_la_fecha, desde_la_fecha , movws, @iter,  title, default, header, money)
                end
              end
            elsif cliente_id.to_i > 0
              movws.add_row ["Movimientos de Cuentas","De cliente", "Generado :" + Time.now.to_date.to_s], :style => title
              movws.merge_cells 'A1:I1'
              @cliente = Cliente.find(cliente_id)
              monedas.split(",").collect{ |s| s.to_i }.each do |moneda_id|
                movimientos_cliente(@cliente, sucursal_id, insucursal, moneda_id,a_la_fecha, desde_la_fecha , movws, @iter , title, default, header, money)
              end
            end
          elsif grupo_id == '0'
            movws.add_row ["Movimientos de Cuentas","Por Grupo", "Generado :" + Time.now.to_date.to_s], :style => title
            movws.merge_cells 'A1:I1'
            for gr in Tipocliente.all

              @titulo = gr.nombre
              movws.add_row [@titulo], :style => title
              movws.merge_cells 'A'+@iter.to_s+':D'+@iter.to_s
              @iter += 1
              for cliente in gr.cliente
                monedas.split(",").collect{ |s| s.to_i }.each do |moneda_id|
                  movimientos_cliente(cliente, sucursal_id, insucursal,moneda_id, a_la_fecha, desde_la_fecha , movws, @iter, title, default, header, money)
                end
              end
            end
          elsif grupo_id.to_i > 0
            movws.add_row ["Movimientos de Cuentas","Del grupo", "Generado :" + Time.now.to_date.to_s], :style => title
            movws.merge_cells 'A1:I1'
            @gr = Tipocliente.find(grupo_id)

            @titulo = 'Grupo - '+ @gr.nombre

            movws.add_row [@titulo], :style => title
            movws.merge_cells 'A'+@iter.to_s+':D'+@iter.to_s
            @iter += 1
            for cliente in @gr.cliente
              monedas.split(",").collect{ |s| s.to_i }.each do |moneda_id|
                movimientos_cliente(cliente, sucursal_id, insucursal,moneda_id, a_la_fecha, desde_la_fecha , movws, @iter, title, default, header, money)
              end
            end
          end
        end
        return p
    end

    def self.articulos_emitidos( grupo_id, cliente_id, sucursal_id, inicio, fin, insucursal )
      p = Axlsx::Package.new
        p.workbook do |wb|

          title = wb.styles.add_style(:sz => 5, :b => true, :u => true)
          default = wb.styles.add_style(:border => Axlsx::STYLE_THIN_BORDER)
          header = wb.styles.add_style(:bg_color => '3399FF', :b => true)
          money = wb.styles.add_style(:format_code => '#,###,##0.00', :border => Axlsx::STYLE_THIN_BORDER)

          movws =  wb.add_worksheet(:name => 'Artículos')

          grafsws =  wb.add_worksheet(:name => 'Gráficas')
          grafsws.add_row [""], :style => title
          grafsws.add_row ["", "Próximamente..."], :style => title

          @iter = 1

          if grupo_id.nil?
            if cliente_id.nil?
              movws.add_row ["Movimientos de Artículos Por fecha Generado :" + Time.now.to_date.to_s], :style => title
              movws.merge_cells 'A1:I1'
              @iter += 1
              articulos_cliente( nil , sucursal_id, insucursal, inicio, fin , movws, @iter, title, default, header, money)
            elsif cliente_id == '0'
              movws.add_row ["Movimientos de Artículos Por cliente Generado :" + Time.now.to_date.to_s], :style => title
              movws.merge_cells 'A1:I1'
              @iter += 1
              for cliente in Cliente.all
                articulos_cliente( cliente , sucursal_id, insucursal, inicio, fin , movws, @iter, title, default, header, money)
                #@iter += 1
              end
            elsif cliente_id.to_i > 0
              movws.add_row ["Movimientos de Artículos De un cliente Generado :" + Time.now.to_date.to_s], :style => title
              movws.merge_cells 'A1:I1'
              @iter += 1
              @cliente = Cliente.find(cliente_id)
              articulos_cliente( @cliente , sucursal_id, insucursal, inicio, fin , movws, @iter, title, default, header, money)
            end
          elsif grupo_id == '0'
            movws.add_row ["Movimientos de Artículos Por grupo Generado :" + Time.now.to_date.to_s], :style => title
            movws.merge_cells 'A1:I1'
            @iter += 1
            for gr in Tipocliente.all

              @titulo = 'Grupo - '+ gr.nombre
              movws.add_row [@titulo], :style => title
              movws.merge_cells 'A'+@iter.to_s+':D'+@iter.to_s
              @iter += 1
              for cliente in gr.cliente
                articulos_cliente( cliente , sucursal_id, insucursal, inicio, fin , movws, @iter, title, default, header, money)
                #@iter += 1
              end
            end
          elsif grupo_id.to_i > 0
            movws.add_row ["Movimientos de Artículos De un grupo Generado :" + Time.now.to_date.to_s], :style => title
            movws.merge_cells 'A1:I1'
            @gr = Tipocliente.find(grupo_id)
            @titulo = 'Grupo - '+ @gr.nombre
            movws.add_row [@titulo], :style => title
            movws.merge_cells 'A'+@iter.to_s+':D'+@iter.to_s
            @iter += 2
            for cliente in @gr.cliente
              articulos_cliente( cliente , sucursal_id, insucursal, inicio, fin , movws, @iter, title, default, header, money)
              #@iter += 1
            end
          end
        end
        return p
    end



    private


    def self.emision_cliente( cliente, sucursal_id, insucursal, inicio, fin, facturas, credito ,pendientes, vencidas, recibos, ndcs, ndvs, ndds , factws, factcdws, recws, ndcws, ndvws, nddws, totalws , condicion, iterfact, iterfactcd, iterrec, iterndc, iterndv, iterndd, itertotal, title, default, header, money, formtot )
      # define your regular styles
      #percent = styles.add_style(:num_fmt => Axlsx::NUM_FMT_PERCENT, :border => Axlsx::STYLE_THIN_BORDER)
      # define the style for conditional formatting - its the :dxf bit that counts!
      #profitable =  styles.add_style(:fg_color=> 'FF428751', :sz => 12, :type => :dxf, :b => true)

      if !cliente.nil?
        condicion += "and comerciante_id = '" + cliente.id.to_s + "'"
      end

      @sucnom = ''
      if (sucursal_id != nil and sucursal_id.to_i > 0)
        condicion += 'AND sucursal_id ='+sucursal_id.to_s + ' '
        @sucnom = ' - '+Sucursal.find(sucursal_id).nombre
      elsif  insucursal == "0"
        condicion += ' and sucursal_id IS NULL '
      end

      if !inicio.nil? and (inicio.to_s != "")
        condicion += 'and fecha >= ' +" '"+ inicio+ "'"
        @sucnom += ' - ' + inicio
      end
      if !fin.nil? and (fin.to_s != "")
        condicion += " AND fecha <= '"+ fin +"' "
        @sucnom += ' - ' + fin
      end

      if facturas == "true"
        factws.add_row
        @iterfact += 1
        @titulo = (cliente.nil? ? "Todos los Clientes" : cliente.nombre) + @sucnom
        factws.add_row [@titulo], :style => title
        #factws.merge_cells 'A'+@iterfact.to_s+':D'+@iterfact.to_s
        factws.add_row
        if (sucursal_id != nil and sucursal_id == "0")
          @orden = "sucursal_id, fecha, numero"
        else
          @orden = "fecha, numero"
        end

        @filums = ['Cuenta','Nro', 'Fecha',"Sucursal" ,"RUT", 'Tipo','Moneda','Estado', 'Total s/impuestos' ]
        for impu in @impuestos
          @auxc = ""
          @auxc << impu
          @auxc.sub! 'IVA          2', 'IVA 10'
          @filums << @auxc
        end
        @filums << 'Total impuestos'
        @filums << 'Total'

        #total_impuestos_discriminado
        factws.add_row @filums, :style => header

        @condfact = condicion + " and contado = 1 "
        @iterfact += 3
        @iter_inicio = @iterfact
        @entro = false
        for fact in Factura.where(@condfact).order(@orden)
          @entro = true

          if (fact.impresa)
            if (fact.anulada)
              @mensaje = 'Anulada'
            else
              @mensaje = 'Impresa'
            end
          else
            @mensaje = 'No Impresa'
          end

          @tipo = "Contado"

          if fact.sucursal_id != nil
            @nombre_sucursal = fact.sucursal.nombre
            @cuenta = fact.sucursal.id
          else
            @nombre_sucursal = fact.comerciante.nombre
            @cuenta = fact.comerciante.id
          end


          @stile = [default, default, default, default, default, default, default, default, money, money, money]
          @filumsx = [@cuenta, fact.numero.to_s, fact.fecha.to_s, @nombre_sucursal, fact.comerciante.nif, @tipo, fact.moneda.nombre,@mensaje]
          if (fact.anulada) then
            @filumsx << 0
            for impue in @impuestos
               @filumsx << 0
               @stile << money
            end
            @filumsx << 0
            @filumsx << 0
          else
            @filumsx << fact.total_sinimpuestos

            @impuestofa = fact.total_impuestos_discriminado
            @coltimp = 'I'
            for impue in @impuestos
              @stile << money
              @coltimp = @coltimp.next
              @tiene = false
              for impuex in @impuestofa
                  if (impue == impuex["nombre"])
                     @filumsx << impuex["imp"]
                     @tiene = true
                  end
              end
              if !@tiene
                 @filumsx << 0
              end
            end

            if (@calculo_impuestos == 0)
              @filumsx << '=SUM(J'+@iterfact.to_s + ':'+@coltimp.to_s + @iterfact.to_s + ')'
            else
              @filumsx << fact.total_impuestos
            end
            @filumsx << '=I'+@iterfact.to_s + '+'+@coltimp.next.to_s + @iterfact.to_s
          end

          factws.add_row @filumsx,:style => @stile

          @iterfact += 1
        end

        if @entro

          @stile = [default, default, default,default,default, default, default, default ,money, money, money]
          @filumsx = ["", "", "" , "","" ,"","","Totales",'=SUM(I'+@iter_inicio.to_s+':I'+(@iterfact - 1).to_s+')']

          @coltimp = 'I'
          for impue in @impuestos
            @stile << money
            @coltimp = @coltimp.next
            @filumsx << '=SUM('+@coltimp.to_s+@iter_inicio.to_s+':'+@coltimp.to_s+(@iterfact - 1).to_s+')'
          end

          @filumsx << '=SUM('+@coltimp.next.to_s+@iter_inicio.to_s+':'+@coltimp.next.to_s+(@iterfact - 1).to_s+')'
          @filumsx << '=SUM('+@coltimp.next.next.to_s+@iter_inicio.to_s+':'+@coltimp.next.next.to_s+(@iterfact - 1).to_s+')'

          if pendientes == "true" or vencidas == "true"
            @filumsx << '=SUM('+@coltimp.next.next.next.to_s+@iter_inicio.to_s+':'+@coltimp.next.next.next.to_s+(@iterfact - 1).to_s+')'
          end

          factws.add_row @filumsx,:style => @stile

          @formtot[0] += "+'Contado'!I" + @iterfact.to_s

          @iterfact +=1
        end

      end


      if credito == "true"
        factcdws.add_row
        @iterfactcd += 1
        @titulo = (cliente.nil? ? "Todos los clientes" : cliente.nombre) + @sucnom
        factcdws.add_row [@titulo], :style => title
        factcdws.merge_cells 'A'+@iterfactcd.to_s+':D'+@iterfactcd.to_s
        factcdws.add_row
        if (sucursal_id != nil and sucursal_id == "0")
          @orden = "sucursal_id, fecha, numero"
        else
          @orden = "fecha, numero"
        end

        @condfactcd = condicion + " and contado = 0 "

        @filums = ['Cuenta', 'Nro', 'Fecha',"Sucursal","RUT", 'Tipo','Moneda','Estado' ,'Total s/impuestos']
        for impu in @impuestos
          @auxc = ""
          @auxc << impu
          @auxc.sub! 'IVA          2', 'IVA 10'
          @filums << @auxc
        end
        @filums << 'Total impuestos'
        @filums << 'Total'
        factcdws.add_row @filums, :style => header

        if pendientes == "true" or vencidas == "true"
          @condfactcd += " AND adeudo >= 1"
          @filums << 'Saldo'
        end


        @iterfactcd += 3
        @iter_inicio = @iterfactcd
        @entro = false
        for fact in Factura.where(@condfactcd).order(@orden)
          @entro = true
          if vencidas == "true" and !fact.vencida
              next
          end


          if (fact.impresa)
            if (fact.anulada)
              @mensaje = 'Anulada'
            else
              @mensaje = 'Impresa'
            end
          else
            @mensaje = 'No Impresa'
          end

          @tipo = "Credito"

          if fact.sucursal_id != nil
            @nombre_sucursal = fact.sucursal.nombre
            @cuenta = fact.sucursal.id
          else
            @nombre_sucursal = fact.comerciante.nombre
            @cuenta = fact.comerciante.id
          end

          @stile = [default, default, default, default, default, default, default, default ,money, money,money]
          @filumsx = [@cuenta, fact.numero.to_s, fact.fecha.to_s,@nombre_sucursal, fact.comerciante.nif, @tipo,fact.moneda.nombre,@mensaje]
          if (fact.anulada) then
            @filumsx << 0
            for impue in @impuestos
               @filumsx << 0
               @stile << money
            end
            @filumsx << 0
            @filumsx << 0
          else
            @filumsx << fact.total_sinimpuestos
            @impuestofa = fact.total_impuestos_discriminado

            @coltimp = 'I'
            for impue in @impuestos
              @stile << money
              @coltimp = @coltimp.next
              @tiene = false
              for impuex in @impuestofa
                  if (impue == impuex["nombre"])
                     @filumsx << impuex["imp"]
                     @tiene = true
                  end
              end
              if !@tiene
                 @filumsx << 0
              end
            end
            if (@calculo_impuestos == 0)
              @filumsx << '=SUM(J'+@iterfactcd.to_s + ':'+@coltimp.to_s + @iterfactcd.to_s + ')'
            else
              @filumsx << fact.total_impuestos
            end
            @filumsx << '=I'+@iterfactcd.to_s + '+'+@coltimp.next.to_s + @iterfactcd.to_s

            if pendientes == "true" or vencidas == "true"
              @filumsx << fact.adeudo
              @stile << money
            end

          end

          factcdws.add_row @filumsx,:style => @stile

          @iterfactcd += 1
        end

        if @entro

          @stile = [default, default, default,default,default, default, default, default ,money, money, money]
          @filumsx = ["", "", "" , "", "" , "", "", "Totales", '=SUM(I'+@iter_inicio.to_s+':I'+(@iterfactcd - 1).to_s+')']

          @coltimp = 'I'
          for impue in @impuestos
            @stile << money
            @coltimp = @coltimp.next
            @filumsx << '=SUM('+@coltimp.to_s+@iter_inicio.to_s+':'+@coltimp.to_s+(@iterfactcd - 1).to_s+')'
          end

          @filumsx << '=SUM('+@coltimp.next.to_s+@iter_inicio.to_s+':'+@coltimp.next.to_s+(@iterfactcd - 1).to_s+')'
          @filumsx << '=SUM('+@coltimp.next.next.to_s+@iter_inicio.to_s+':'+@coltimp.next.next.to_s+(@iterfactcd - 1).to_s+')'

          if pendientes == "true" or vencidas == "true"
            @filumsx << '=SUM('+@coltimp.next.next.next.to_s+@iter_inicio.to_s+':'+@coltimp.next.next.next.to_s+(@iterfactcd - 1).to_s+')'
            @stile << money
          end
          factcdws.add_row @filumsx,:style => @stile

          @formtot[1] += "+'Crédito'!I" + @iterfactcd.to_s

          @iterfactcd +=1
        end
      end


      if recibos == "true"
        recws.add_row
        @iterrec += 1
        @titulo = (cliente.nil? ? "Todos los Clientes" : cliente.nombre) +  @sucnom
        recws.add_row [@titulo], :style => title
        recws.merge_cells 'A'+@iterrec.to_s+':D'+@iterrec.to_s
        recws.add_row

        if (sucursal_id != nil and sucursal_id == "0")
          @orden = "sucursal_id, fecha, numero"
        else
          @orden = "fecha, numero"
        end
        recws.add_row ['Nro', 'Fecha', "Sucursal",'Moneda','Estado', 'Total'], :style => header
        @iterrec += 3

        @iter_inicio = @iterrec
        @entro = false
        for fact in Recibo.where(condicion).order(@orden)
          @entro = true
          if (fact.impresa )
            if (fact.anulada )
              @mensaje = 'Anulada'
            else
              @mensaje = 'Impresa'
            end
          else
            @mensaje = 'No Impresa'
          end

          if fact.sucursal_id != nil
            @nombre_sucursal = fact.sucursal.nombre
          else
            @nombre_sucursal = fact.comerciante.nombre
          end

          recws.add_row [fact.numero.to_s, fact.fecha.to_s, @nombre_sucursal ,fact.moneda.nombre,@mensaje,fact.total_sinimpuestos],:style => [default,default,default, default, default, money]

          @iterrec += 1

        end

        if @entro
          recws.add_row ["", "", "" ,"","Total",'=SUM(F'+@iter_inicio.to_s+':F'+(@iterrec - 1).to_s+')'],:style => [default,default,default, default, default, money]
          @iterrec += 1
        end
      end

      if ndcs == "true"
        ndcws.add_row
        @iterndc += 1
        @titulo = ( cliente.nil? ? "Todos los Clientes" : cliente.nombre) + @sucnom
        ndcws.add_row [@titulo], :style => title
        ndcws.merge_cells 'A'+@iterndc.to_s+':D'+@iterndc.to_s
        ndcws.add_row

        if (sucursal_id != nil and sucursal_id == "0")
          @orden = "sucursal_id, fecha, numero"

        else
          @orden = "fecha, numero"
        end

        @condndc = condicion

        @filums = ['Cuenta', 'Nro', 'Fecha',"Sucursal", "RUT", 'Moneda','Estado' ,'Total s/impuestos']
        for impu in @impuestos
          @auxc = ""
          @auxc << impu
          @auxc.sub! 'IVA          2', 'IVA 10'
          @filums << @auxc
        end
        @filums << 'Total impuestos'
        @filums << 'Total'

        if pendientes == "true" and !Setting.documentos_asociados
          @condndc += " AND adeudo <= -1"
          @filumsx << "Saldo"
        end
        ndcws.add_row @filums, :style => header

        @iterndc += 3
        @iter_inicio = @iterndc
        @entro = false

        for fact in Notadecredito.where( @condndc + " and es_devolucion = 0").order(@orden)
          @entro = true
          if (fact.impresa)
            if (fact.anulada )
              @mensaje = 'Anulada'
            else
              @mensaje = 'Impresa'
            end
          else
            @mensaje = 'No Impresa'
          end


          if fact.sucursal_id != nil
            @nombre_sucursal = fact.sucursal.nombre
            @cuenta = fact.sucursal.id
          else
            @nombre_sucursal = fact.comerciante.nombre
            @cuenta = fact.comerciante.id
          end

          @stile = [default, default, default, default, default, default, default ,money, money, money]
          @filumsx = [@cuenta, fact.numero.to_s, fact.fecha.to_s, @nombre_sucursal, fact.comerciante.nif, fact.moneda.nombre,@mensaje]
          if (fact.anulada) then
            @filumsx << 0
            for impue in @impuestos
               @filumsx << 0
               @stile << money
            end
            @filumsx << 0
            @filumsx << 0
            if pendientes == "true" and !Setting.documentos_asociados
              @filumsx << 0
              @stile << money
            end
          else
            @filumsx << fact.total_sinimpuestos
            @impuestofa = fact.total_impuestos_discriminado
            @coltimp = 'H'
            for impue in @impuestos
              @stile << money
              @coltimp = @coltimp.next
              @tiene = false
              for impuex in @impuestofa
                  if (impue == impuex["nombre"])
                     @filumsx << impuex["imp"]
                     @tiene = true
                  end
              end
              if !@tiene
                 @filumsx << 0
              end
            end
            if (@calculo_impuestos == 0)
              @filumsx << '=SUM(I'+@iterndc.to_s + ':'+@coltimp.to_s + @iterndc.to_s + ')'
            else
              @filumsx << fact.total_impuestos
            end
            @filumsx << '=H'+@iterndc.to_s + '+'+@coltimp.next.to_s + @iterndc.to_s


            if pendientes == "true" and !Setting.documentos_asociados
              @filumsx << -fact.adeudo
              @stile << money
            end

          end

          ndcws.add_row @filumsx, :style => @stile

          @iterndc += 1
        end

        if @entro

          @stile = [default, default,default,default, default, default, default ,money, money, money]
          @filumsx = ["", "", "", "" ,"", "", "Totales",'=SUM(H'+@iter_inicio.to_s+':H'+(@iterndc - 1).to_s+')']

          @coltimp = 'H'
          for impue in @impuestos
            @stile << money
            @coltimp = @coltimp.next
            @filumsx << '=SUM('+@coltimp.to_s+@iter_inicio.to_s+':'+@coltimp.to_s+(@iterndc - 1).to_s+')'
          end

          @filumsx << '=SUM('+@coltimp.next.to_s+@iter_inicio.to_s+':'+@coltimp.next.to_s+(@iterndc - 1).to_s+')'
          @filumsx << '=SUM('+@coltimp.next.next.to_s+@iter_inicio.to_s+':'+@coltimp.next.next.to_s+(@iterndc - 1).to_s+')'


          if pendientes == "true" and !Setting.documentos_asociados
            @filumsx << '=SUM('+@coltimp.next.next.next.to_s+@iter_inicio.to_s+':'+@coltimp.next.next.next.to_s+(@iterndc - 1).to_s+')'
            @stile << money
          end

          ndcws.add_row @filumsx,:style => @stile

          @formtot[3] += "+'Notas de Crédito'!H" + @iterndc.to_s

          @iterndc += 1

        end
      end



      if ndvs == "true"
        ndvws.add_row
        @iterndv += 1
        @titulo = ( cliente.nil? ? "Todos los Clientes" : cliente.nombre) + @sucnom
        ndvws.add_row [@titulo], :style => title
        ndvws.merge_cells 'A'+@iterndv.to_s+':D'+@iterndv.to_s
        ndvws.add_row

        if (sucursal_id != nil and sucursal_id == "0")
          @orden = "sucursal_id, fecha, numero"

        else
          @orden = "fecha, numero"

        end

        @filums = ['Cuenta', 'Nro', 'Fecha',"Sucursal", "RUT", 'Moneda','Estado' ,'Total s/impuestos']
        for impu in @impuestos
          @auxc = ""
          @auxc << impu
          @auxc.sub! 'IVA          2', 'IVA 10'
          @filums << @auxc
        end
        @filums << 'Total impuestos'
        @filums << 'Total'

        ndvws.add_row @filums, :style => header

        @iterndv += 3
        @iter_inicio = @iterndv
        @entro = false

        for fact in Notadecredito.where(condicion+" and es_devolucion = 1").order(@orden)

          @entro = true

          if (fact.impresa)
            if (fact.anulada )
              @mensaje = 'Anulada'
            else
              @mensaje = 'Impresa'
            end
          else
            @mensaje = 'No Impresa'
          end

          if fact.sucursal_id != nil
            @nombre_sucursal = fact.sucursal.nombre
            @cuenta = fact.sucursal.id
          else
            @nombre_sucursal = fact.comerciante.nombre
            @cuenta = fact.comerciante.id
          end

          @stile = [default, default, default, default, default, default, default ,money, money,money]
          @filumsx = [@cuenta, fact.numero.to_s, fact.fecha.to_s,@nombre_sucursal, fact.comerciante.nif, fact.moneda.nombre,@mensaje]
          if (fact.anulada) then
            @filumsx << 0
            for impue in @impuestos
               @filumsx << 0
               @stile << money
            end
            @filumsx << 0
            @filumsx << 0
          else
            @filumsx << fact.total_sinimpuestos
            @impuestofa = fact.total_impuestos_discriminado
            @coltimp = 'H'
            for impue in @impuestos
              @stile << money
              @coltimp = @coltimp.next
              @tiene = false
              for impuex in @impuestofa
                  if (impue == impuex["nombre"])
                     @filumsx << impuex["imp"]
                     @tiene = true
                  end
              end
              if !@tiene
                 @filumsx << 0
              end
            end
            if (@calculo_impuestos == 0)
              @filumsx << '=SUM(I'+@iterndv.to_s + ':'+@coltimp.to_s + @iterndv.to_s + ')'
            else
              @filumsx << fact.total_impuestos
            end
            @filumsx << '=H'+@iterndv.to_s + '+'+@coltimp.next.to_s + @iterndv.to_s

          end

          ndvws.add_row @filumsx, :style => @stile

          @iterndv += 1
        end

        if @entro
          @stile = [default, default, default, default, default, default, default, money, money, money]
          @filumsx = ["", "", "", "", "", "", "Totales", '=SUM(H'+@iter_inicio.to_s+':H'+(@iterndv - 1).to_s+')']

          @coltimp = 'H'
          for impue in @impuestos
            @stile << money
            @coltimp = @coltimp.next
            @filumsx << '=SUM('+@coltimp.to_s+@iter_inicio.to_s+':'+@coltimp.to_s+(@iterndv - 1).to_s+')'
          end

          @filumsx << '=SUM('+@coltimp.next.to_s+@iter_inicio.to_s+':'+@coltimp.next.to_s+(@iterndv - 1).to_s+')'
          @filumsx << '=SUM('+@coltimp.next.next.to_s+@iter_inicio.to_s+':'+@coltimp.next.next.to_s+(@iterndv - 1).to_s+')'

          ndvws.add_row @filumsx,:style => @stile

          @formtot[2] += "+'Notas de Devolución'!H" + @iterndv.to_s

          @iterndv += 1
        end
      end


      if Setting.usar_notadd

        if ndds == "true"
          nddws.add_row
          @iterndd += 1
          @titulo = cliente.nil? ? "Todos los Clientes" : cliente.nombre + @sucnom
          nddws.add_row [@titulo], :style => title
          nddws.merge_cells 'A'+@iterndd.to_s+':D'+@iterndd.to_s
          nddws.add_row
          if (sucursal_id != nil and sucursal_id == "0")
            @orden = "sucursal_id, fecha, numero"

          else
            @orden = "fecha, numero"

          end
          nddws.add_row ['Nro', 'Fecha','Sucursal','Moneda','Estado' ,'Total s/impuestos','Total impuestos','Total'], :style => header
          @iterndd += 3
          @iter_inicio = @iterndd
          @entro = false

          for fact in Notadedebito.where(condicion)
            @entro = true

            if (fact.impresa)
              if (fact.anulada )
                @mensaje = 'Anulada'
              else
                @mensaje = 'Impresa'
              end
            else
              @mensaje = 'No Impresa'
            end


            @nombre_sucursal = fact.comerciante.nombre
            if fact.sucursal_id != nil
              @nombre_sucursal = fact.sucursal.nombre
            end
            nddws.add_row [fact.numero.to_s, fact.fecha.to_s,@nombre_sucursal , fact.moneda.nombre,@mensaje,fact.total_sinimpuestos,fact.total_impuestos, '=SUM(F'+@iterndd.to_s+':G'+@iterndd.to_s+')'],:style => [default,default,default,default ,money, money,money,money, money,money]

            @iterndd += 1

          end


          if @entro

            nddws.add_row ["", "","" , "","Totales",'=SUM(F'+@iter_inicio.to_s+':F'+(@iterndd - 1).to_s+')','=SUM(G'+@iter_inicio.to_s+':G'+(@iterndd - 1).to_s+')', '=SUM(F'+@iterndd.to_s+':G'+@iterndd.to_s+')'],:style => [default,default,default, default,default,money,money,money]

            @formtot[4] += "+SUM('Notas de Débito'!F" + @iter_inicio.to_s + ":'Notas de Débito'!F" + (@iterndd - 1).to_s + ")"

            @iterndd += 1
          end
        end
      end

    end

    def self.movimientos_cliente( cliente , sucursal_id, insucursal, moneda_id, a_la_fecha, desde_la_fecha , movws, iter, title, default, header, money)



      @sucnom = ''
      @condicion =  'moneda_id = ' + moneda_id.to_s

      if !cliente.nil?
        @condicion += " and cliente_id = '" + cliente.id.to_s + "'"
      end

      if (sucursal_id != nil and sucursal_id.to_i > 0)
        @condicion += ' and sucursal_id ='+sucursal_id.to_s
        @sucnom = ' - '+Sucursal.find(sucursal_id).nombre
      elsif insucursal == "0"
        @condicion += ' and sucursal_id IS NULL '
      end

      movws.add_row
      @iter += 1
      if (sucursal_id != nil and (insucursal == "1") and (sucursal_id == "0"))
        @orden = "sucursal_id, fecha"
      else
        @orden = "fecha"
      end
      if !a_la_fecha.nil? and (a_la_fecha.to_s != "" )
          @condicion += ' AND fecha >= ' +" '"+ a_la_fecha +"' "
      end
      if !desde_la_fecha.nil? and (desde_la_fecha.to_s != "" )
          @condicion += " AND fecha <= '"+ desde_la_fecha +"' "
      end


      if ((a_la_fecha.to_s == "") and (desde_la_fecha.to_s == "") )
        if ( !MovimientoCliente.where(@condicion).empty? )
          @titulo = 'Saldo actual - '+ cliente.nombre + @sucnom + " - " + Moneda.find(moneda_id).nombre
          movws.add_row [@titulo], :style => title
          movws.merge_cells 'A'+@iter.to_s+':D'+@iter.to_s
          movws.add_row

          movws.add_row [ "Sucursal" ,'Moneda','Saldo'], :style => header
          @iter += 3

          if (sucursal_id != nil and sucursal_id == "0")
            @mov_id = MovimientoCliente.where(@condicion).maximum("id")
            if !@mov_id.nil?
              @mov = MovimientoCliente.find( @mov_id)
              movws.add_row [ cliente.nombre, @mov.moneda.nombre , @mov.saldo ],:style => [default,default,money]
              @iter += 1
            end
            for suc in cliente.sucursals
              @mov_id = cliente.movimientos.where(@condicion + " and sucursal_id = '" + suc.id.to_s + "'").maximum("id")
              if !@mov_id.nil?
                @mov = cliente.movimientos.find( @mov_id)
                @nombre_sucursal = @mov.sucursal.nombre
                movws.add_row [ @nombre_sucursal, @mov.moneda.nombre , @mov.saldo_sucursal ],:style => [default, default, money]
                @iter += 1
              end

            end

          else
            @mov_id = cliente.movimientos.where(@condicion).maximum("id")
            if !@mov_id.nil?
              @mov = MovimientoCliente.find( @mov_id  )
              movws.add_row [@mov.moneda.nombre , @mov.saldo ],:style => [ default,money]
              @iter += 1
            end
          end

        end
      else

        @movs = cliente.movimientos.where(@condicion).order(@orden)
        if (@movs.size() > 0)

          @titulo = 'Movimientos - '+ cliente.nombre + @sucnom +' - ' + a_la_fecha + ' - ' + desde_la_fecha  + " - " +Moneda.find(moneda_id).nombre
          movws.add_row [@titulo], :style => title
          movws.merge_cells 'A'+@iter.to_s+':D'+@iter.to_s
          movws.add_row

          if (sucursal_id != nil and sucursal_id == "0")
            movws.add_row [ "Sucursal" ,'Fecha', 'Operación' ,'Nro','Documento','Moneda','Debe','Haber','Saldo','Debe Sucursal','Haber Sucursal','Saldo Sucursal'], :style => header
          else
            movws.add_row ['Fecha' , 'Operación', 'Nro','Documento','Moneda','Debe','Haber','Saldo'], :style => header
            @orden = "fecha"
          end
          @iter += 3

          if !a_la_fecha.nil? and (a_la_fecha.to_s != "" )
            @condicion += ' AND fecha >= ' +" '"+ a_la_fecha +"' "
          end
          if !desde_la_fecha.nil? and (desde_la_fecha.to_s != "" )
            @condicion += " AND fecha <= '"+ desde_la_fecha +"' "
          end

          for mov in @movs

            if (sucursal_id != nil and sucursal_id == "0")
              if mov.sucursal_id != nil
                @nombre_sucursal = mov.sucursal.nombre
              else
                @nombre_sucursal = "Casa Central: " + mov.cliente.nombre
              end
              movws.add_row [ @nombre_sucursal, mov.fecha.to_s, mov.operacion, mov.documento.numero, ( mov.documento.class.name == "Notadecredito" and mov.documento.es_devolucion ) ? "Nota de devolución" : (mov.documento.class.name == "Notadecredito" ? "Nota de crédito" : mov.documento.class.name) , mov.moneda.nombre , mov.debe, mov.haber, mov.saldo , mov.debe_sucursal, mov.haber_sucursal, mov.saldo_sucursal  ],:style => [default, default,default,default,money,money,money,money,money,money, money, money]
            elsif (sucursal_id.to_i > 0)
              movws.add_row [  mov.fecha.to_s, mov.operacion, mov.documento.numero, ( mov.documento.class.name == "Notadecredito" and mov.documento.es_devolucion ) ? "Nota de devolución" : (mov.documento.class.name == "Notadecredito" ? "Nota de crédito" : mov.documento.class.name) , mov.moneda.nombre , mov.debe_sucursal, mov.haber_sucursal, mov.saldo_sucursal ],:style => [default, default,default,default,money,money,money,money,money,money, money, money]
            else
              movws.add_row [  mov.fecha.to_s, mov.operacion, mov.documento.numero, ( mov.documento.class.name == "Notadecredito" and mov.documento.es_devolucion ) ? "Nota de devolución" : (mov.documento.class.name == "Notadecredito" ? "Nota de crédito" : mov.documento.class.name) , mov.moneda.nombre , mov.debe, mov.haber, mov.saldo ],:style => [default, default,default,default,money,money,money,money,money,money, money, money]
            end

            @iter += 1

          end
        end
      end


          # Apply conditional formatting to range B4:B7 in the worksheet
          #ws.add_conditional_formatting('B4:B7', { :type => :cellIs,
          #                                :operator => :greaterThan,
          #                                :formula => '27000000',
          #                                :dxfId => profitable,
          #                                :priority => 1 })
    end



    def self.articulos_cliente( cliente , sucursal_id, insucursal, inicio, fin , movws, iter, title, default, header, money)
      @sucnom = ''
      @condicion = '1=1  '
      @condicion_nc = '1=1 '
      @condicion_nd = '1=1 '
      @nomCliente = ''

      if (cliente != nil )
        @nomCliente += ' - '+ cliente.nombre
        @condicion += ' and fa.comerciante_id = ' + cliente.id.to_s
        @condicion_nc += ' and ndc.comerciante_id = ' + cliente.id.to_s
        if Setting.usar_notadd
          @condicion_nd += ' and ndd.comerciante_id = ' + cliente.id.to_s
        end
      end

      if ((sucursal_id != nil) and (sucursal_id.to_i > 0))
        @condicion += ' and fa.sucursal_id = '+sucursal_id.to_s
        @condicion_nc += ' and ndc.sucursal_id = '+sucursal_id.to_s
        if Setting.usar_notadd
          @condicion_nd += ' and ndd.sucursal_id = '+sucursal_id.to_s
        end
        @sucnom = ' - '+ Sucursal.find(sucursal_id.to_i).nombre
      elsif insucursal == "0"
        @condicion += ' and fa.sucursal_id IS NULL'
        @condicion_nc += ' and ndc.sucursal_id IS NULL'
        if Setting.usar_notadd
          @condicion_nd += ' and ndd.sucursal_id IS NULL'
        end
      end

      if (fin.nil? || fin.to_s == "") and (inicio.nil? || inicio.to_s == "")
        @titulo = 'Artículos Vendidos '+ @nomCliente + @sucnom
      elsif inicio.nil? || inicio.to_s == "" and ( !fin.nil? || fin.to_s != "" )
        @condicion += " AND fa.fecha <= '"+ fin + "' "
        @condicion_nc += " AND ndc.fecha <= '"+ fin + "' "
        if Setting.usar_notadd
          @condicion_nd += " and ndd.fecha <= '"+ fin + "' "
        end

        @titulo = 'Artículos Vendidos '+ @nomCliente + @sucnom + " - " +fin
      elsif fin.nil? || fin.to_s == ""
        @condicion += " AND fa.fecha >= '"+ inicio + "' "
        @condicion_nc += " AND ndc.fecha >= '"+ inicio + "' "
        if Setting.usar_notadd
          @condicion_nd += " and notadedebitos.fecha >= '"+ inicio + "' "
        end

        @titulo = 'Artículos Vendidos '+ @nomCliente + @sucnom + " - " +inicio
      else
        @condicion += " and (fa.fecha BETWEEN '"+ inicio +"' AND '"+ fin +"')"
        @condicion_nc += " and (ndc.fecha BETWEEN '"+ inicio +"' AND '"+ fin +"')"
        if Setting.usar_notadd
          @condicion_nd += " and (ndd.fecha BETWEEN '"+ inicio +"' AND '"+ fin +"')"
        end
        @titulo = 'Artículos Vendidos '+ @nomCliente + @sucnom + " - " + inicio +" - " +fin
      end

      movws.add_row
      movws.add_row [@titulo], :style => title
      movws.merge_cells 'A'+@iter.to_s+':D'+@iter.to_s

      @iter += 2

      @parametro = ''
      if (sucursal_id != nil and insucursal == "1" and sucursal_id == "0")
        @parametro += 'sucursal_id ,'
        movws.add_row [ "Sucursal", 'Articulo', 'Entregados', 'Devueltos', "Importe Vendido", "Importe Devuelto", "Total", "Saldo"], :style => header
      else
        movws.add_row ['Artículo', 'Entregados', 'Devueltos', "Importe Vendido", "Importe Devuelto", "Total", "Saldo"], :style => header
      end

      @iter += 1

      config   = Rails.configuration.database_configuration
      database = config[Rails.env]["database"]

      if Setting.documentos_asociados
        if Setting.usar_notadd

        else

        end
      else
         if Setting.usar_notadd

         else
          #@query = RenglonFactura.connection.select_all("SELECT SUM( IF( renglon_notacreditos.cantidad is null , renglon_facturas.cantidad , renglon_facturas.cantidad - renglon_notacreditos.cantidad ))  AS sum_cantidad, " + @parametro + " renglon_facturas.comercializable_id, notadecreditos.es_devolucion FROM " + database +".renglon_facturas INNER JOIN " + database +".facturas ON facturas.id = renglon_facturas.factura_id LEFT OUTER JOIN ( SELECT * FROM ( " + database + ".notadecreditos  INNER JOIN " + database + ".renglon_notacreditos ON notadecreditos.id = renglon_notacreditos.notadecredito_id ) WHERE " + @condicion_nc + " GROUP BY (es_devolucion, " +  @parametro + " comercializable_id) ) AS r_notacreditos ON renglon_facturas.comercializable_id = r_notacreditos.comercializable_id WHERE "+ @condicion + " GROUP BY es_devolucion, " +  @parametro + " comercializable_id ORDER BY " + @parametro + " comercializable_id " )
          @query = RenglonFactura.connection.select_all("SELECT " +  @parametro + "result.id_cm, SUM(result.cantEntregados) AS entregados, SUM(result.cantDevueltos) as devueltos, SUM(result.importeEntregado) AS debitado, SUM(result.importeDevueltos) AS acreditado
                                                        from ( SELECT " +  @parametro + "cm.id as id_cm
                                                          , SUM( CASE WHEN rf1.cantidad IS NOT NULL THEN rf1.cantidad ELSE 0 END ) as cantEntregados
                                                          , 0 as cantDevueltos
                                                          , SUM( rf1.total_renglon ) as importeEntregado
                                                          , 0 as importeDevueltos
                                                          FROM " + database +".facturas as fa
                                                          JOIN " + database +".renglon_facturas as rf1 ON (fa.id = rf1.factura_id)
                                                          JOIN " + database +".rolarticulos as cm ON (rf1.comercializable_id = cm.id)
                                                          WHERE "+ @condicion + "
                                                          AND (fa.impresa = '1') AND (fa.anulada = '0')
                                                          GROUP BY " +  @parametro + "id_cm

                                                          UNION

                                                          SELECT " +  @parametro + "cm.id as id_cm
                                                          , 0 as cantEntregados
                                                          , SUM( CASE WHEN rndc.cantidad IS NOT NULL THEN rndc.cantidad ELSE 0 END ) as cantDevueltos
                                                          , 0 as importeEntregado
                                                          , SUM( rndc.total_renglon ) as importeDevueltos
                                                          FROM " + database +".notadecreditos as ndc
                                                          JOIN " + database +".renglon_notacreditos as rndc ON (ndc.id = rndc.notadecredito_id)
                                                          JOIN " + database +".rolarticulos as cm ON (rndc.comercializable_id = cm.id)
                                                          WHERE "+ @condicion_nc + "
                                                          AND (ndc.impresa = '1') AND (ndc.anulada = '0')
                                                          GROUP BY " +  @parametro + "id_cm


                                                          UNION

                                                          SELECT " +  @parametro + "cm.id as id_cm
                                                          , 0 as cantEntregados
                                                          , SUM( CASE WHEN rndv.cantidad IS NOT NULL THEN rndv.cantidad ELSE 0 END ) as cantDEvueltos
                                                          , 0 as importeEntregado
                                                          , SUM( rndv.total_renglon ) as importeDevueltos
                                                          FROM " + database +".notadecreditos as ndc
                                                          JOIN " + database +".renglon_ndc_articulos as rndv ON (ndc.id = rndv.notadecredito_id)
                                                          JOIN " + database +".rolarticulos as cm ON (rndv.comercializable_id = cm.id)
                                                          WHERE "+ @condicion_nc +"
                                                          AND (ndc.impresa = '1') AND (ndc.anulada = '0')
                                                          GROUP BY " +  @parametro + "id_cm

                                                        )  result
                                                          GROUP BY " +  @parametro + "id_cm
                                                          ; ")

         end
      end


      if (sucursal_id != nil and sucursal_id == "0")
          (0..(@query.count-1)).each do |ra|
            @nombreArticulo = Articulo.find(Comercializable.find(@query[ra]['id_cm'] ).rola_id).nombre
            @sucnom = ''
            if !(@query[ra]["sucursal_id"].nil? or @query[ra]["sucursal_id"] == "")
              @sucnom = Sucursal.find(@query[ra]["sucursal_id"]).nombre
            else
              @sucnom = @nomCliente
            end
            movws.add_row [ @sucnom, @nombreArticulo , @query[ra]["entregados"],@query[ra]["devueltos"],@query[ra]["debitado"],@query[ra]["acreditado"],"=C"+@iter.to_s+"-D"+@iter.to_s,"=E"+@iter.to_s+"-F"+@iter.to_s ],:style => [default,default,default,default,money,money,default,money]
            @iter += 1
          end
      else
          (0..(@query.count-1)).each do |ra|
            @nombreArticulo = Articulo.find(Comercializable.find(@query[ra]['id_cm'] ).rola_id).nombre
            movws.add_row [ @nombreArticulo , @query[ra]["entregados"],@query[ra]["devueltos"],@query[ra]["debitado"],@query[ra]["acreditado"],"=B"+@iter.to_s+"-C"+@iter.to_s,"=D"+@iter.to_s+"-E"+@iter.to_s ],:style => [default,default,default,money,money,default,money]
            @iter += 1
          end
      end

    end

  end
