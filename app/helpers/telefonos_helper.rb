module TelefonosHelper
  
  def redirigirTelefono (contelefono)
   print contelefono.class.name + " la puta clase  "
    if contelefono.class.name == "Empresa"
      @idemp = contelefono.id.to_s
      @goto = "/empresas/"+@idemp
    elsif contelefono.class.name == "Persona"
      @idper = contelefono.id.to_s
      @goto = "/personas/"+@idper
    elsif contelefono.class.name == "Sucursal"
      @idemp = contelefono.empresa.id.to_s
      @idenc = contelefono.id.to_s
      @goto = "/empresas/"+@idemp+"/sucursals/"+@idenc
    elsif contelefono.class.name == "Contacto"
      print contelefono.contactable.class.name + " la sub clases  "
      if  contelefono.contactable.class.name == "Empresa"
        @idemp = contelefono.contactable.id.to_s
        @idcon = contelefono.id.to_s
        @goto = "/empresas/"+@idemp+"/contactos/"+@idcon
      elsif contelefono.contactable.class.name == "Sucursal"
        @idemp = contelefono.contactable.empresa.id.to_s
        @idsuc = contelefono.contactable.id.to_s
        @idcon = contelefono.id.to_s
        @goto = "/empresas/"+@idemp+"/sucursals/"+@idsuc+"/contactos/"+@idcon

      end
    end
    return @goto
  end
end
