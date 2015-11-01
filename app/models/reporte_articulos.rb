# encoding: utf-8
require 'axlsx'

class ReporteArticulos

  def self.conjunto_articulos( inicio, fin, comercializable_ids_rep, cliente_ids_rep, empsuc)
    p = Axlsx::Package.new
    p.workbook do |wb|


      title = wb.styles.add_style( :b => true, :u => true, :wrap_text => true)
      default = wb.styles.add_style( :border => Axlsx::STYLE_THIN_BORDER, :edges => [:top, :bottom, :left, :right], :wrap_text => true)
      header = wb.styles.add_style( :bg_color => '3399FF', :b => true, :border => Axlsx::STYLE_THIN_BORDER, :edges => [:top, :bottom, :left, :right], :wrap_text => true)
      money = wb.styles.add_style(:sz => 15, :format_code => '#,###,##0.00', :border => Axlsx::STYLE_THIN_BORDER, :wrap_text => true)


      conjws =  wb.add_worksheet(:name => 'Artículos Vendidos')

      conjDws =  wb.add_worksheet(:name => 'Artículos Devueltos')

      grafsws =  wb.add_worksheet(:name => 'Gráficas')

      @iter_conjws = 0
      p1_conjunto_articulos( inicio, fin , conjws, comercializable_ids_rep, cliente_ids_rep, empsuc, title, default, header, money)

      @iter_conjDws = 0
      p1_conjunto_articulos_dev( inicio, fin , conjDws, comercializable_ids_rep, cliente_ids_rep, empsuc, title, default, header, money)

      graficas(grafsws, conjws, conjDws)

      return p
    end
  end

  private

  def self.p1_conjunto_articulos( inicio, fin , conjws, comercializable_ids_rep, cliente_ids_rep, empsuc, title, default, header, money)

    if (inicio == "")
      cond_inicio = "1=1"
    else
      cond_inicio = "fa.fecha >= '" + inicio + "'"
    end

    if (fin == "")
      cond_fin = "1=1"
    else
      cond_fin = "fa.fecha <= '" + fin + "'"
    end

    if (comercializable_ids_rep == "")
      cond_comerc = "1=1"
    else
      cond_comerc = "at.id IN (" + comercializable_ids_rep + ")"
    end

    if (cliente_ids_rep == "")
      cond_cli = "1=1"
    else
      if (empsuc == "emp")
        cond_cli = "fa.comerciante_id IN (" + cliente_ids_rep + ")"
      else
        cond_cli = "fa.comerciante_id IN (" + cliente_ids_rep + ") OR fa.sucursal_id IN (" + cliente_ids_rep + ")"
      end
    end

    query = "select at.id as num, at.nombre as nom, SUM(rf.cantidad) as vtotal
                from articulos as at
                inner join renglon_facturas as rf on (rf.comercializable_id = at.id)
                inner join facturas as fa on (fa.id = rf.factura_id)
                Where (fa.impresa = 1 AND fa.anulada = 0)
                AND (" + cond_inicio + ")
                AND (" + cond_fin + ")
                AND (" + cond_comerc + ")
                AND (" + cond_cli + ")
                group by at.id, at.nombre
                order by at.nombre;";

    data = ActiveRecord::Base.connection.execute(query);

    titulo = ["Artículos Vendidos entre " + inicio + " y "+ fin + " - Generado: " + Time.now.to_date.to_s]
    titulo << ""
    titulo << ""
    if (empsuc == "emp")
      txt_cli = "Empresas"
    else
      txt_cli = "Sucursales"
    end
    titulo << txt_cli
    if (cliente_ids_rep == "")
      titulo << "Todos"
    else
      cliente_ids_rep.split(",").collect{ |s| s.to_i }.each do |cli|
        titulo << cli
      end
    end

    conjws.add_row titulo, :style => title
    conjws.merge_cells 'A1:C1'
    @iter_conjws += 1
    conjws.add_row [""]
    conjws.add_row ["Numero Artículo","Nombre Artículo","Total Unidades Vendidas"], :style => header
    @iter_conjws += 2

    data.each do  |ra|
      conjws.add_row [ra[0], ra[1], ra[2]], :style => default
      @iter_conjws += 1
    end


    conjws.column_widths 20, 40, 30, 14


  end

  def self.p1_conjunto_articulos_dev( inicio, fin , conjDws, comercializable_ids_rep, cliente_ids_rep, empsuc, title, default, header, money)

    if (inicio == "")
      cond_inicio = "1=1"
    else
      cond_inicio = "ndc.fecha >= '" + inicio + "'"
    end

    if (fin == "")
      cond_fin = "1=1"
    else
      cond_fin = "ndc.fecha <= '" + fin + "'"
    end

    if (comercializable_ids_rep == "")
      cond_comerc = "1=1"
    else
      cond_comerc = "at.id IN (" + comercializable_ids_rep + ")"
    end

    if (cliente_ids_rep == "")
      cond_cli = "1=1"
    else
      if (empsuc == "emp")
        cond_cli = "ndc.comerciante_id IN (" + cliente_ids_rep + ")"
      else
        cond_cli = "ndc.comerciante_id IN (" + cliente_ids_rep + ") OR ndc.sucursal_id IN (" + cliente_ids_rep + ")"
      end
    end

    query = "select at.id, at.nombre, SUM(rnc.cantidad) as vtotal -- , fa.id, fa.numero
                from articulos as at
                inner join renglon_ndc_articulos as rnc on (rnc.comercializable_id = at.id)
                inner join notadecreditos as ndc on (ndc.id = rnc.notadecredito_id)
                Where (ndc.impresa = 1 AND ndc.anulada = 0)
                AND (" + cond_inicio + ")
                AND (" + cond_fin + ")
                AND (" + cond_comerc + ")
                AND (" + cond_cli + ")
                group by at.id, at.nombre
                order by at.nombre
                ;";

    data = ActiveRecord::Base.connection.execute(query);

    conjDws.add_row ["Artículos Devueltos entre " + inicio + " y "+ fin + " - Generado: " + Time.now.to_date.to_s], :style => title
    conjDws.merge_cells 'A1:C1'
    @iter_conjDws += 1
    conjDws.add_row [""]
    conjDws.add_row ["Numero Artículo","Nombre Artículo","Total Unidades Devueltas"], :style => header
    @iter_conjDws += 2

    data.each do  |ra|
      conjDws.add_row [ra[0], ra[1], ra[2]], :style => default
      @iter_conjDws += 1
    end

    conjDws.column_widths 20, 40, 30

  end

  def self.graficas(grafsws, conjws, conjDws)

    if(@iter_conjws >= 4)
      grafsws.add_chart(Axlsx::Bar3DChart, :start_at => "B2", :end_at => "O24", :bar_dir => :col) do |chart|
        chart.add_series :data => conjws["C4:C"+@iter_conjws.to_s], :labels => conjws["B4:B"+@iter_conjws.to_s], :title => conjws["A1"], :colors => ["00FF00", "0000FF"]
        chart.catAxis.tick_lbl_pos = :none
      end

      grafsws.add_chart(Axlsx::Pie3DChart, :start_at => "P2", :end_at => "AB24") do |chart|
        chart.add_series :data => conjws["C4:C"+@iter_conjws.to_s], :labels => conjws["B4:B"+@iter_conjws.to_s], :title => conjws["A1"], :colors => ["00FF00", "0000FF"]
      end
    end

    if(@iter_conjDws >= 4)
      grafsws.add_chart(Axlsx::Bar3DChart, :start_at => "B25", :end_at => "O47", :bar_dir => :col) do |chart|
        chart.add_series :data => conjDws["C4:C"+@iter_conjDws.to_s], :labels => conjDws["B4:B"+@iter_conjDws.to_s], :title => conjDws["A1"], :colors => ["00FF00", "0000FF"]
        chart.catAxis.tick_lbl_pos = :none
      end

      grafsws.add_chart(Axlsx::Pie3DChart, :start_at => "P25", :end_at => "AB47") do |chart|
        chart.add_series :data => conjDws["C4:C"+@iter_conjDws.to_s], :labels => conjDws["B4:B"+@iter_conjDws.to_s], :title => conjDws["A1"], :colors => ["00FF00", "0000FF"]
      end
    end

  end

end