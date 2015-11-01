class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper



  #Si tiene documentos asociados cada documento o bien es una factura o cada documento
  # que no sea una factura tiene en sus renglones siempre asociado una factura.
  Setting.documentos_asociados = false

  #cuando se crea un recibo se decide si se generan renglones_docs
  Setting.generar_renglon_recibo = true

  #Si usa o no nota de debitos
  Setting.usar_notadd = false

  #cantidad de renglones por paginas cuando se imprime un documentos.
  #se asume que en todos los casos son los mismos
  Setting.renglones_por_hoja = 12

  #Inica si las cuentas de las casas centrales son independientes de las sucursales.
  Setting.saldo_cc_independiente = true

  #tipo 0: precioReal = precio * descuento = precio * MAX{desc_lista, desc_art, desc_cli, desc_promo}
  #tipo 1: precioReal = precio * descuento = precio * MAX{desc_lista, desc_art, desc_cli} * desc_promo
  Setting.tipo_calc_promo = 1



end
