module MailInternosHelper
  
  def redirigirMail (conmail)
    if conmail.class.name == "Empresa"
        @idemp = conmail.id.to_s
        @goto = "/empresas/"+@idemp
    elsif conmail.class.name == "Persona"
        @idper = conmail.id.to_s
        @goto = "/personas/"+@idper
    elsif conmail.class.name == "Sucursal"
        @idemp = conmail.empresa.id.to_s
        @idenc = conmail.id.to_s
        @goto = "/empresas/"+@idemp+"/sucursals/"+@idenc
    elsif conmail.class.name == "Contacto"
        if  conmail.contactable.class.name == "Empresa"
          @idemp = conmail.contactable.id.to_s
          @idcon = conmail.id.to_s
          @goto = "/empresas/"+@idemp+"/contactos/"+@idcon
        elsif conmail.contactable.class.name == "Sucursal"
          @idemp = conmail.contactable.empresa.id.to_s
          @idsuc = conmail.contactable.id.to_s
          @idcon = conmail.id.to_s
          @goto = "/empresas/"+@idemp+"/sucursals/"+@idsuc+"/contactos/"+@idcon
        end
    elsif @conmail.class.name == "Tipocliente"
      @goto = "/tipoclientes/"+ @conmail.id.to_s

    end
    return @goto
  end

end
