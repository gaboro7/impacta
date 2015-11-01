
class ReportesController < ApplicationController

  before_filter :authenticate
  before_filter :parametros


  def facturado
    respond_to do |format|
      xlsx_package = ComercializacionCliente.emision(params[:grupo_id],params[:cliente_id],params[:sucursal_id], params[:insucursal],
                       params[:inicio],params[:fin],params[:facturas],params[:credito],params[:pendientes], params[:vencidas] ,params[:recibos],params[:ndcs],
                       params[:ndvs], params[:ndds],params[:anuladas])
      format.xlsx  {
        begin
          temp = Tempfile.new("facturado.xlsx")
          xlsx_package.serialize temp.path
          #if params[:email].nil? || !UserMailer.enviar(params[:email],params[:subject],params[:message],temp.path,"facturado.xlsx").deliver
          send_file temp.path, :filename => "facturado.xlsx", :type => "application/xlsx"
          #end
          
        ensure
          temp.close
          #temp.unlink
        end
        
      }
      format.json {
        if !params[:email].nil?
          @mails_bad = ""
          params[:email].to_s.split(',').each do |mil|
             if !MailInterno.mail_valido(mil)
               @mails_bad += mil.to_s
             end
          end

          if (@mails_bad == "")
            begin
              temp = Tempfile.new("facturado.xlsx")
              xlsx_package.serialize temp.path
              if  UserMailer.enviar(params[:email],params[:subject],params[:message],temp.path,"facturado.xlsx").deliver
                render json: [:envio => "Envio de mails OK"]
              else
                render json: [:envio => "Algun mail de los ingresados no fue aceptado."]
              end
            ensure
              temp.close
              #temp.unlink
            end
          else
            render json: [:envio => @mails_bad+" Formato de mails incorrecto."]
          end
        else
          render json: [:envio => "No se ingreso un mail."]
        end

        }
    end
  end

  def movimientos
    respond_to do |format|
      format.xlsx  {
        xlsx_package = ComercializacionCliente.movimientos(params[:grupo_id],params[:cliente_id],params[:sucursal_id], params[:insucursal],
                       params[:monedas],params[:inicio],params[:fin])
        begin
          temp = Tempfile.new("movimientos.xlsx")
          xlsx_package.serialize temp.path
          if params[:email].nil? || !UserMailer.enviar(params[:email],params[:subject],params[:message],temp.path,"movimientos.xlsx").deliver
            send_file temp.path, :filename => "movimientos.xlsx", :type => "application/xlsx"
          end
        ensure
          temp.close
          #temp.unlink
        end
      }

    end
  end

  def articulos_reporte
    respond_to do |format|
      format.xlsx  {
        xlsx_package = ComercializacionCliente.articulos_emitidos(params[:grupo_id],params[:cliente_id],params[:sucursal_id],
                       params[:inicio],params[:fin], params[:insucursal])
        begin
          temp = Tempfile.new("articulos.xlsx")
          xlsx_package.serialize temp.path
          if params[:email].nil? || !UserMailer.enviar(params[:email],params[:subject],params[:message],temp.path,"articulos.xlsx").deliver
            send_file temp.path, :filename => "articulos.xlsx", :type => "application/xlsx"
          end
        ensure
          temp.close
          #temp.unlink http://hiltmon.com/blog/2013/01/11/ruby-tempfile-aggressive-unlink/
        end
      }

    end
  end

  def conjunto_articulos_reporte
    respond_to do |format|
      format.xlsx  {
        xlsx_package = ReporteArticulos.conjunto_articulos(params[:inicio],params[:fin], params[:comercializable_ids_rep], params[:cliente_ids_rep], params[:empsuc])
        begin
          temp = Tempfile.new("reporte_conj_articulos.xlsx")
          xlsx_package.serialize temp.path
          if params[:email].nil? || !UserMailer.enviar(params[:email],params[:subject],params[:message],temp.path,"reporte_conj_articulos.xlsx").deliver
            send_file temp.path, :filename => "reporte_conj_articulos.xlsx", :type => "application/xlsx"
          end
        ensure
          temp.close
        end
      }

    end
  end

  private

  def parametros
    if params[:grupo_id].to_i == -1
       params[:grupo_id] = nil
    end
    if params[:cliente_id].to_i == -1
      params[:cliente_id] = nil
    end
    if params[:sucursal_id].to_i == -1
       params[:sucursal_id] = nil
    end

    if params[:subject].nil? || params[:subject].to_s == ""
       params[:subject] = "Sin asunto"
    end

    if params[:message].nil?
       params[:message] = ""
    end

    if params[:grupo_id].to_i < -1 or params[:cliente_id].to_i < -1 or params[:sucursal_id].to_i < -1
      deny_access
    end

  end
end
