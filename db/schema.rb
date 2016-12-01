# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130316213029) do

  create_table "articulos", :force => true do |t|
    t.string   "type",        :null => false
    t.string   "nombre",      :null => false
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articulos_articulocomps", :force => true do |t|
    t.integer  "articulo_id"
    t.integer  "articulocomp_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articulos_articulocomps", ["articulo_id", "articulocomp_id"], :name => "articulos_articulos_compuestos"

  create_table "articulos_rolarticulos", :id => false, :force => true do |t|
    t.integer  "rolarticulo_id"
    t.integer  "articulo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articulos_rolarticulos", ["articulo_id"], :name => "index_articulos_rolarticulos_on_articulo_id"
  add_index "articulos_rolarticulos", ["rolarticulo_id"], :name => "index_articulos_rolarticulos_on_rolarticulo_id"

  create_table "celularcons", :force => true do |t|
    t.string   "cellular",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clientes", :force => true do |t|
    t.string   "type",                              :null => false
    t.boolean  "credito",        :default => false
    t.float    "precargo"
    t.string   "urecargo"
    t.integer  "cantrecargo"
    t.float    "pdescuento",     :default => 0.0
    t.boolean  "habilitado",     :default => true
    t.integer  "listaprecio_id"
    t.integer  "tipocliente_id"
    t.string   "domicilio",                         :null => false
    t.string   "departamento"
    t.string   "barrio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nombre",                            :null => false
    t.string   "nic"
    t.string   "nombrereal"
    t.string   "nombrefiscal"
    t.string   "nif"
    t.string   "dirweb"
  end

  add_index "clientes", ["listaprecio_id"], :name => "index_clientes_on_listaprecio_id"
  add_index "clientes", ["tipocliente_id"], :name => "index_clientes_on_tipocliente_id"

  create_table "clientes_formadepagos", :id => false, :force => true do |t|
    t.integer  "cliente_id"
    t.integer  "formadepago_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clientes_formadepagos", ["cliente_id"], :name => "index_clientes_formadepagos_on_cliente_id"
  add_index "clientes_formadepagos", ["formadepago_id"], :name => "index_clientes_formadepagos_on_formadepago_id"

  create_table "clientes_promocions", :force => true do |t|
    t.integer  "cliente_id",   :null => false
    t.integer  "promocion_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clientes_promocions", ["cliente_id"], :name => "index_clientes_promocions_on_cliente_id"
  add_index "clientes_promocions", ["promocion_id"], :name => "index_clientes_promocions_on_promocion_id"

  create_table "comercializables_impuestos", :id => false, :force => true do |t|
    t.integer  "comercializable_id"
    t.string   "comercializable_type", :default => "Rolarticulo"
    t.integer  "impuesto_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comercializables_impuestos", ["comercializable_id"], :name => "index_comercializables_impuestos_on_comercializable_id"
  add_index "comercializables_impuestos", ["impuesto_id"], :name => "index_comercializables_impuestos_on_impuesto_id"

  create_table "comercializables_promocions", :id => false, :force => true do |t|
    t.integer  "comercializable_id"
    t.integer  "promocion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comercializables_promocions", ["comercializable_id"], :name => "index_comercializables_promocions_on_comercializable_id"
  add_index "comercializables_promocions", ["promocion_id"], :name => "index_comercializables_promocions_on_promocion_id"

  create_table "contactos", :force => true do |t|
    t.string   "nombre",           :null => false
    t.string   "sector"
    t.integer  "interno"
    t.text     "comentarios"
    t.integer  "contactable_id",   :null => false
    t.string   "contactable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contactos", ["contactable_id"], :name => "index_contactos_on_contactable_id"

  create_table "descuento_clientes", :force => true do |t|
    t.integer  "cliente_id",         :null => false
    t.integer  "comercializable_id", :null => false
    t.float    "descuento",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "descuento_clientes", ["cliente_id"], :name => "index_descuento_clientes_on_cliente_id"
  add_index "descuento_clientes", ["comercializable_id"], :name => "index_descuento_clientes_on_comercializable_id"

  create_table "domicilios", :force => true do |t|
    t.string   "domicilio"
    t.integer  "persona_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facturas", :force => true do |t|
    t.string   "rut",                                  :null => false
    t.string   "direccion_cliente",                    :null => false
    t.boolean  "contado",                              :null => false
    t.string   "detalle"
    t.date     "fecha",                                :null => false
    t.string   "codigo_barras"
    t.integer  "comerciante_id",                       :null => false
    t.string   "comerciante_type",                     :null => false
    t.integer  "sucursal_id"
    t.integer  "formadepago_id"
    t.integer  "moneda_id",                            :null => false
    t.string   "nom_moneda"
    t.float    "tipo_de_cambio"
    t.boolean  "impresa",           :default => false
    t.boolean  "anulada",           :default => false
    t.float    "adeudo",            :default => 0.0
    t.string   "numero"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facturas", ["comerciante_id", "comerciante_type", "adeudo"], :name => "index_facturas_on_comerciante_id_and_comerciante_type_and_adeudo"
  add_index "facturas", ["comerciante_id", "comerciante_type"], :name => "index_facturas_on_comerciante_id_and_comerciante_type"
  add_index "facturas", ["fecha"], :name => "index_facturas_on_fecha"
  add_index "facturas", ["formadepago_id"], :name => "index_facturas_on_formadepago_id"
  add_index "facturas", ["id", "contado"], :name => "index_facturas_on_id_and_contado"
  add_index "facturas", ["moneda_id"], :name => "facturas_moneda_id_fk"
  add_index "facturas", ["numero"], :name => "index_facturas_on_numero"
  add_index "facturas", ["sucursal_id"], :name => "facturas_sucursal_id_fk"

  create_table "formadepagos", :force => true do |t|
    t.string   "nombre",                            :null => false
    t.string   "estado",                            :null => false
    t.boolean  "predeterminada", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cantidad"
    t.string   "type",                              :null => false
    t.string   "unidad"
  end

  create_table "formadepagos_monedas", :id => false, :force => true do |t|
    t.integer  "formadepago_id", :null => false
    t.integer  "moneda_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "formadepagos_monedas", ["formadepago_id", "moneda_id"], :name => "index_formadepagos_monedas_on_formadepago_id_and_moneda_id"
  add_index "formadepagos_monedas", ["moneda_id"], :name => "formadepagos_monedas_moneda_id_fk"

  create_table "formadepagos_promocions", :id => false, :force => true do |t|
    t.integer  "formadepago_id"
    t.integer  "promocion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "formadepagos_promocions", ["formadepago_id"], :name => "index_formadepagos_promocions_on_formadepago_id"
  add_index "formadepagos_promocions", ["promocion_id"], :name => "index_formadepagos_promocions_on_promocion_id"

  create_table "foto_impuesto_facts", :force => true do |t|
    t.string   "nombre",       :null => false
    t.float    "porcentaje",   :null => false
    t.integer  "renglon_id",   :null => false
    t.string   "renglon_type", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foto_impuesto_ndcs", :force => true do |t|
    t.integer  "renglon_id",   :null => false
    t.string   "renglon_type", :null => false
    t.string   "nombre",       :null => false
    t.float    "porcentaje",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foto_impuesto_ndcs", ["renglon_id", "renglon_type"], :name => "index_foto_impuesto_ndcs_on_renglon_id_and_renglon_type"

  create_table "foto_impuesto_ndds", :force => true do |t|
    t.integer  "renglon_id",   :null => false
    t.string   "renglon_type", :null => false
    t.string   "nombre",       :null => false
    t.float    "porcentaje",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foto_impuesto_ndds", ["renglon_id", "renglon_type"], :name => "index_foto_impuesto_ndds_on_renglon_id_and_renglon_type"

  create_table "foto_impuesto_recs", :force => true do |t|
    t.string   "nombre",                :null => false
    t.float    "porcentaje",            :null => false
    t.integer  "renglon_recdetalle_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foto_impuesto_recs", ["renglon_recdetalle_id"], :name => "index_foto_impuesto_recs_on_renglon_recdetalle_id"

  create_table "impresiones", :force => true do |t|
    t.boolean  "anulada",         :default => false
    t.integer  "cant_paginas",    :default => 1
    t.integer  "imprimible_id",                      :null => false
    t.string   "imprimible_type",                    :null => false
    t.boolean  "contado"
    t.integer  "numero",                             :null => false
    t.string   "serie",                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impresiones", ["imprimible_id", "imprimible_type", "contado"], :name => "impresiones_indice_contado"
  add_index "impresiones", ["imprimible_id", "imprimible_type", "numero", "serie"], :name => "impresiones_indice"
  add_index "impresiones", ["imprimible_id", "imprimible_type"], :name => "index_impresiones_on_imprimible_id_and_imprimible_type"

  create_table "impresiones_facts", :force => true do |t|
    t.integer  "numero",                          :null => false
    t.string   "serie",                           :null => false
    t.boolean  "anulada",      :default => false
    t.integer  "cant_paginas", :default => 1
    t.integer  "factura_id",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impresiones_facts", ["factura_id"], :name => "index_impresiones_facts_on_factura_id"
  add_index "impresiones_facts", ["numero", "serie"], :name => "index_impresiones_facts_on_numero_and_serie"

  create_table "impresiones_ndcs", :force => true do |t|
    t.boolean  "anulada",          :default => false
    t.integer  "cant_paginas",     :default => 1
    t.integer  "notadecredito_id",                    :null => false
    t.integer  "numero",                              :null => false
    t.string   "serie",                               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impresiones_ndcs", ["notadecredito_id"], :name => "index_impresiones_ndcs_on_notadecredito_id"
  add_index "impresiones_ndcs", ["numero", "serie"], :name => "index_impresiones_ndcs_on_numero_and_serie"

  create_table "impresiones_ndds", :force => true do |t|
    t.boolean  "anulada",         :default => false
    t.integer  "cant_paginas",    :default => 1
    t.integer  "notadedebito_id",                    :null => false
    t.integer  "numero",                             :null => false
    t.string   "serie",                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impresiones_ndds", ["notadedebito_id"], :name => "index_impresiones_ndds_on_notadedebito_id"
  add_index "impresiones_ndds", ["numero", "serie"], :name => "index_impresiones_ndds_on_numero_and_serie"

  create_table "impresiones_recs", :force => true do |t|
    t.integer  "numero",                          :null => false
    t.string   "serie",                           :null => false
    t.boolean  "anulada",      :default => false
    t.integer  "cant_paginas", :default => 1
    t.integer  "recibo_id",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impresiones_recs", ["numero", "serie"], :name => "index_impresiones_recs_on_numero_and_serie"
  add_index "impresiones_recs", ["recibo_id"], :name => "index_impresiones_recs_on_recibo_id"

  create_table "impuestos", :force => true do |t|
    t.string   "nombre",                       :null => false
    t.float    "porcentajea",                  :null => false
    t.float    "porcentajec", :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impuestos_renglon_factdetalles", :id => false, :force => true do |t|
    t.integer  "impuesto_id",            :null => false
    t.integer  "renglon_factdetalle_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impuestos_renglon_factdetalles", ["impuesto_id"], :name => "index_impuestos_renglon_factdetalles_on_impuesto_id"
  add_index "impuestos_renglon_factdetalles", ["renglon_factdetalle_id"], :name => "index_impuestos_renglon_factdetalles_on_renglon_factdetalle_id"

  create_table "impuestos_renglon_ndcdetalles", :force => true do |t|
    t.integer  "impuesto_id",           :null => false
    t.integer  "renglon_ndcdetalle_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impuestos_renglon_ndcdetalles", ["impuesto_id"], :name => "index_impuestos_renglon_ndcdetalles_on_impuesto_id"
  add_index "impuestos_renglon_ndcdetalles", ["renglon_ndcdetalle_id"], :name => "index_impuestos_renglon_ndcdetalles_on_renglon_ndcdetalle_id"

  create_table "impuestos_renglon_ndcs", :force => true do |t|
    t.integer  "impuesto_id"
    t.integer  "renglon_id"
    t.string   "renglon_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impuestos_renglon_ndcs", ["impuesto_id"], :name => "index_impuestos_renglon_ndcs_on_impuesto_id"

  create_table "impuestos_renglon_ndddetalles", :force => true do |t|
    t.integer  "impuesto_id",           :null => false
    t.integer  "renglon_ndddetalle_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impuestos_renglon_ndddetalles", ["impuesto_id"], :name => "index_impuestos_renglon_ndddetalles_on_impuesto_id"
  add_index "impuestos_renglon_ndddetalles", ["renglon_ndddetalle_id"], :name => "index_impuestos_renglon_ndddetalles_on_renglon_ndddetalle_id"

  create_table "impuestos_renglon_ndds", :force => true do |t|
    t.integer  "impuesto_id"
    t.integer  "renglon_id"
    t.string   "renglon_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impuestos_renglon_ndds", ["impuesto_id"], :name => "index_impuestos_renglon_ndds_on_impuesto_id"

  create_table "impuestos_renglon_recdetalles", :id => false, :force => true do |t|
    t.integer  "impuesto_id",           :null => false
    t.integer  "renglon_recdetalle_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impuestos_renglon_recdetalles", ["impuesto_id"], :name => "index_impuestos_renglon_recdetalles_on_impuesto_id"
  add_index "impuestos_renglon_recdetalles", ["renglon_recdetalle_id"], :name => "index_impuestos_renglon_recdetalles_on_renglon_recdetalle_id"

  create_table "listaprecios", :force => true do |t|
    t.string   "nombre",                            :null => false
    t.boolean  "predeterminada", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_internos", :force => true do |t|
    t.string   "mail"
    t.integer  "conmail_id",   :null => false
    t.string   "conmail_type", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monedas", :force => true do |t|
    t.string   "nombre",                            :null => false
    t.float    "tipodecambio",   :default => 0.0
    t.boolean  "predeterminada", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movimiento_clientes", :force => true do |t|
    t.integer  "documento_id"
    t.string   "documento_type"
    t.integer  "cliente_id",     :null => false
    t.integer  "sucursal_id"
    t.string   "operacion",      :null => false
    t.date     "fecha",          :null => false
    t.float    "debe",           :null => false
    t.float    "haber",          :null => false
    t.float    "saldo",          :null => false
    t.integer  "moneda_id",      :null => false
    t.float    "debe_sucursal"
    t.float    "haber_sucursal"
    t.float    "saldo_sucursal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movimiento_clientes", ["cliente_id", "fecha", "moneda_id"], :name => "index_movimientos_clientes_reportes1"
  add_index "movimiento_clientes", ["cliente_id", "sucursal_id", "fecha", "moneda_id"], :name => "index_movimientos_clientes_reportes1_con_sucursal"
  add_index "movimiento_clientes", ["cliente_id"], :name => "index_movimiento_clientes_on_cliente_id"
  add_index "movimiento_clientes", ["documento_id", "documento_type"], :name => "index_movimiento_clientes_on_documento_id_and_documento_type"

  create_table "notadecreditos", :force => true do |t|
    t.boolean  "anulada",           :default => false
    t.boolean  "es_devolucion",     :default => false
    t.string   "rut",                                  :null => false
    t.string   "direccion_cliente",                    :null => false
    t.string   "codigo_barras"
    t.integer  "comerciante_id",                       :null => false
    t.string   "comerciante_type",                     :null => false
    t.string   "detalle"
    t.date     "fecha",                                :null => false
    t.integer  "moneda_id",                            :null => false
    t.string   "nom_moneda"
    t.float    "tipo_de_cambio"
    t.boolean  "impresa",           :default => false
    t.integer  "sucursal_id"
    t.string   "numero"
    t.float    "adeudo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notadecreditos", ["comerciante_id", "comerciante_type"], :name => "index_notadecreditos_on_comerciante_id_and_comerciante_type"
  add_index "notadecreditos", ["fecha"], :name => "index_notadecreditos_on_fecha"
  add_index "notadecreditos", ["numero"], :name => "index_notadecreditos_on_numero"
  add_index "notadecreditos", ["sucursal_id"], :name => "index_notadecreditos_on_sucursal_id"

  create_table "notadedebitos", :force => true do |t|
    t.boolean  "anulada",           :default => false
    t.string   "rut",                                  :null => false
    t.string   "direccion_cliente",                    :null => false
    t.string   "codigo_barras"
    t.integer  "comerciante_id",                       :null => false
    t.string   "comerciante_type",                     :null => false
    t.string   "detalle"
    t.date     "fecha",                                :null => false
    t.integer  "moneda_id",                            :null => false
    t.string   "nom_moneda"
    t.float    "tipo_de_cambio"
    t.boolean  "impresa",           :default => false
    t.integer  "sucursal_id"
    t.float    "adeudo"
    t.string   "numero"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notadedebitos", ["comerciante_id", "comerciante_type"], :name => "index_notadedebitos_on_comerciante_id_and_comerciante_type"
  add_index "notadedebitos", ["fecha"], :name => "index_notadedebitos_on_fecha"
  add_index "notadedebitos", ["numero"], :name => "index_notadedebitos_on_numero"
  add_index "notadedebitos", ["sucursal_id"], :name => "index_notadedebitos_on_sucursal_id"

  create_table "precioarts", :force => true do |t|
    t.float    "precio",             :default => 0.0
    t.float    "descuento",          :default => 0.0
    t.integer  "comercializable_id",                  :null => false
    t.integer  "listaprecio_id",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "precioarts", ["comercializable_id"], :name => "index_precioarts_on_comercializable_id"
  add_index "precioarts", ["listaprecio_id"], :name => "index_precioarts_on_listaprecio_id"

  create_table "promocions", :force => true do |t|
    t.date     "fechainicio",                  :null => false
    t.date     "fechafin",                     :null => false
    t.float    "descuento",   :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "descripcion"
  end

  add_index "promocions", ["descripcion"], :name => "index_promocions_on_descripcion"
  add_index "promocions", ["fechafin"], :name => "index_promocions_on_fechafin"
  add_index "promocions", ["fechainicio"], :name => "index_promocions_on_fechainicio"

  create_table "recibos", :force => true do |t|
    t.date     "fecha",                                :null => false
    t.string   "codigo_barras"
    t.string   "detalle"
    t.string   "rut",                                  :null => false
    t.string   "direccion_cliente",                    :null => false
    t.integer  "pagocontado_id",                       :null => false
    t.integer  "comerciante_id",                       :null => false
    t.string   "comerciante_type",                     :null => false
    t.integer  "sucursal_id"
    t.integer  "moneda_id",                            :null => false
    t.string   "nom_moneda"
    t.float    "tipo_de_cambio"
    t.boolean  "impresa",           :default => false
    t.boolean  "anulada",           :default => false
    t.string   "numero"
    t.boolean  "manual"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recibos", ["comerciante_id", "comerciante_type"], :name => "index_recibos_on_comerciante_id_and_comerciante_type"
  add_index "recibos", ["fecha"], :name => "index_recibos_on_fecha"
  add_index "recibos", ["moneda_id"], :name => "recibos_moneda_id_fk"
  add_index "recibos", ["numero"], :name => "index_recibos_on_numero"
  add_index "recibos", ["pagocontado_id"], :name => "recibos_pagocontado_id_fk"
  add_index "recibos", ["sucursal_id"], :name => "recibos_sucursal_id_fk"

  create_table "renglon_factdetalles", :force => true do |t|
    t.integer  "factura_id",      :null => false
    t.string   "detalle",         :null => false
    t.float    "total_renglon",   :null => false
    t.float    "total_impuestos", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renglon_factdetalles", ["factura_id"], :name => "index_renglon_factdetalles_on_factura_id"

  create_table "renglon_facturas", :force => true do |t|
    t.integer  "factura_id",                          :null => false
    t.float    "total_renglon",                       :null => false
    t.float    "total_impuestos",                     :null => false
    t.integer  "comercializable_id",                  :null => false
    t.float    "cantidad",                            :null => false
    t.float    "precio_unitario",                     :null => false
    t.float    "descuento",          :default => 0.0
    t.string   "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renglon_facturas", ["comercializable_id"], :name => "index_renglon_facturas_on_comercializable_id"
  add_index "renglon_facturas", ["factura_id"], :name => "index_renglon_facturas_on_factura_id"

  create_table "renglon_ndc_articulos", :force => true do |t|
    t.integer  "comercializable_id",                  :null => false
    t.integer  "notadecredito_id",                    :null => false
    t.float    "cantidad",                            :null => false
    t.float    "precio_unitario",                     :null => false
    t.float    "total_renglon",                       :null => false
    t.float    "total_impuestos",                     :null => false
    t.float    "descuento",          :default => 0.0
    t.string   "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renglon_ndc_articulos", ["comercializable_id"], :name => "index_renglon_ndc_articulos_on_comercializable_id"
  add_index "renglon_ndc_articulos", ["notadecredito_id"], :name => "index_renglon_ndc_articulos_on_notadecredito_id"

  create_table "renglon_ndcdetalles", :force => true do |t|
    t.string   "detalle",          :null => false
    t.integer  "notadecredito_id", :null => false
    t.float    "total_impuestos",  :null => false
    t.float    "total_renglon",    :null => false
    t.integer  "factura_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renglon_ndcdetalles", ["factura_id"], :name => "index_renglon_ndcdetalles_on_factura_id"
  add_index "renglon_ndcdetalles", ["notadecredito_id"], :name => "index_renglon_ndcdetalles_on_notadecredito_id"

  create_table "renglon_ndcndds", :force => true do |t|
    t.integer  "notadecredito_id"
    t.integer  "notadedebito_id"
    t.string   "detalle"
    t.float    "total_renglon"
    t.float    "total_impuestos"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renglon_ndcndds", ["notadecredito_id"], :name => "index_renglon_ndcndds_on_notadecredito_id"
  add_index "renglon_ndcndds", ["notadedebito_id"], :name => "index_renglon_ndcndds_on_notadedebito_id"

  create_table "renglon_ndd_articulos", :force => true do |t|
    t.integer  "notadedebito_id",                     :null => false
    t.integer  "comercializable_id",                  :null => false
    t.float    "cantidad",                            :null => false
    t.float    "precio_unitario",                     :null => false
    t.float    "total_renglon",                       :null => false
    t.float    "total_impuestos",                     :null => false
    t.float    "descuento",          :default => 0.0
    t.string   "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renglon_ndd_articulos", ["comercializable_id"], :name => "index_renglon_ndd_articulos_on_comercializable_id"
  add_index "renglon_ndd_articulos", ["notadedebito_id"], :name => "index_renglon_ndd_articulos_on_notadedebito_id"

  create_table "renglon_ndddetalles", :force => true do |t|
    t.string   "detalle",         :null => false
    t.integer  "notadedebito_id", :null => false
    t.float    "total_impuestos", :null => false
    t.float    "total_renglon",   :null => false
    t.integer  "factura_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renglon_ndddetalles", ["factura_id"], :name => "index_renglon_ndddetalles_on_factura_id"
  add_index "renglon_ndddetalles", ["notadedebito_id"], :name => "index_renglon_ndddetalles_on_notadedebito_id"

  create_table "renglon_nddndcs", :force => true do |t|
    t.integer  "notadecredito_id"
    t.integer  "notadedebito_id"
    t.string   "detalle"
    t.float    "total_renglon"
    t.float    "total_impuestos"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renglon_nddndcs", ["notadecredito_id"], :name => "index_renglon_nddndcs_on_notadecredito_id"
  add_index "renglon_nddndcs", ["notadedebito_id"], :name => "index_renglon_nddndcs_on_notadedebito_id"

  create_table "renglon_notacreditos", :force => true do |t|
    t.integer  "notadecredito_id",                    :null => false
    t.integer  "factura_id",                          :null => false
    t.string   "comentario"
    t.float    "cantidad",                            :null => false
    t.integer  "comercializable_id"
    t.float    "descuento",          :default => 0.0
    t.float    "precio_unitario",                     :null => false
    t.float    "total_impuestos",                     :null => false
    t.float    "total_renglon",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renglon_notacreditos", ["comercializable_id"], :name => "index_renglon_notacreditos_on_comercializable_id"
  add_index "renglon_notacreditos", ["factura_id"], :name => "index_renglon_notacreditos_on_factura_id"
  add_index "renglon_notacreditos", ["notadecredito_id"], :name => "index_renglon_notacreditos_on_notadecredito_id"

  create_table "renglon_notadebitos", :force => true do |t|
    t.integer  "notadedebito_id",                     :null => false
    t.integer  "factura_id",                          :null => false
    t.string   "comentario"
    t.float    "cantidad",                            :null => false
    t.integer  "comercializable_id",                  :null => false
    t.float    "descuento",          :default => 0.0
    t.float    "precio_unitario",                     :null => false
    t.float    "total_impuestos",                     :null => false
    t.float    "total_renglon",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renglon_notadebitos", ["comercializable_id"], :name => "index_renglon_notadebitos_on_comercializable_id"
  add_index "renglon_notadebitos", ["factura_id"], :name => "index_renglon_notadebitos_on_factura_id"
  add_index "renglon_notadebitos", ["notadedebito_id"], :name => "index_renglon_notadebitos_on_notadedebito_id"

  create_table "renglon_recdetalles", :force => true do |t|
    t.integer  "recibo_id",     :null => false
    t.string   "detalle",       :null => false
    t.float    "total_renglon", :null => false
    t.integer  "factura_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renglon_recdetalles", ["factura_id"], :name => "index_renglon_recdetalles_on_factura_id"
  add_index "renglon_recdetalles", ["recibo_id"], :name => "index_renglon_recdetalles_on_recibo_id"

  create_table "renglon_recibo_docs", :force => true do |t|
    t.integer  "recibo_id",      :null => false
    t.integer  "documento_id",   :null => false
    t.string   "documento_type", :null => false
    t.float    "total_renglon",  :null => false
    t.string   "detalle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renglon_recibo_docs", ["documento_id", "documento_type"], :name => "index_renglon_recibo_docs_on_documento_id_and_documento_type"
  add_index "renglon_recibo_docs", ["recibo_id"], :name => "index_renglon_recibo_docs_on_recibo_id"

  create_table "renglon_recibos", :force => true do |t|
    t.integer  "factura_id",    :null => false
    t.integer  "recibo_id",     :null => false
    t.float    "total_renglon", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renglon_recibos", ["factura_id"], :name => "index_renglon_recibos_on_factura_id"
  add_index "renglon_recibos", ["recibo_id"], :name => "index_renglon_recibos_on_recibo_id"

  create_table "rolarticulos", :force => true do |t|
    t.string   "type",                        :null => false
    t.integer  "rola_id",                     :null => false
    t.string   "rola_type",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "descuento",  :default => 0.0
    t.integer  "garantia",   :default => 0
  end

  add_index "rolarticulos", ["rola_id"], :name => "index_rolarticulos_on_rola_id"

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

  create_table "sucursals", :force => true do |t|
    t.string   "nombre",       :null => false
    t.string   "domicilio",    :null => false
    t.string   "departamento"
    t.string   "barrio"
    t.integer  "empresa_id",   :null => false
    t.string   "observacion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sucursals", ["empresa_id"], :name => "index_sucursals_on_empresa_id"

  create_table "telefonos", :force => true do |t|
    t.string   "telefono"
    t.integer  "contelefono_id",   :null => false
    t.string   "contelefono_type", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipoclientes", :force => true do |t|
    t.string   "nombre",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "nombre",                                :null => false
    t.string   "email",                                 :null => false
    t.string   "encrypted_password",                    :null => false
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["nombre"], :name => "index_users_on_nombre", :unique => true

  add_foreign_key "articulos_articulocomps", "articulos", name: "articulos_articulocomps_articulo_id_fk"

  add_foreign_key "articulos_rolarticulos", "articulos", name: "articulos_rolarticulos_articulo_id_fk", dependent: :delete
  add_foreign_key "articulos_rolarticulos", "rolarticulos", name: "articulos_rolarticulos_rolarticulo_id_fk", dependent: :delete

  add_foreign_key "clientes", "listaprecios", name: "clientes_listaprecio_id_fk"
  add_foreign_key "clientes", "tipoclientes", name: "clientes_tipocliente_id_fk"

  add_foreign_key "clientes_formadepagos", "clientes", name: "clientes_formadepagos_cliente_id_fk", dependent: :delete
  add_foreign_key "clientes_formadepagos", "formadepagos", name: "clientes_formadepagos_formadepago_id_fk"

  add_foreign_key "clientes_promocions", "clientes", name: "clientes_promocions_cliente_id_fk"
  add_foreign_key "clientes_promocions", "promocions", name: "clientes_promocions_promocion_id_fk", dependent: :delete

  add_foreign_key "comercializables_impuestos", "impuestos", name: "comercializables_impuestos_impuesto_id_fk"
  add_foreign_key "comercializables_impuestos", "rolarticulos", name: "comercializables_impuestos_comercializable_id_fk", column: "comercializable_id", dependent: :delete

  add_foreign_key "comercializables_promocions", "promocions", name: "comercializables_promocions_promocion_id_fk", dependent: :delete
  add_foreign_key "comercializables_promocions", "rolarticulos", name: "comercializables_promocions_comercializable_id_fk", column: "comercializable_id", dependent: :delete

  add_foreign_key "descuento_clientes", "clientes", name: "descuento_clientes_cliente_id_fk"
  add_foreign_key "descuento_clientes", "rolarticulos", name: "descuento_clientes_comercializable_id_fk", column: "comercializable_id"

  add_foreign_key "facturas", "formadepagos", name: "facturas_formadepago_id_fk"
  add_foreign_key "facturas", "monedas", name: "facturas_moneda_id_fk"
  add_foreign_key "facturas", "sucursals", name: "facturas_sucursal_id_fk"

  add_foreign_key "formadepagos_monedas", "formadepagos", name: "formadepagos_monedas_formadepago_id_fk", dependent: :delete
  add_foreign_key "formadepagos_monedas", "monedas", name: "formadepagos_monedas_moneda_id_fk", dependent: :delete

  add_foreign_key "formadepagos_promocions", "formadepagos", name: "formadepagos_promocions_formadepago_id_fk"
  add_foreign_key "formadepagos_promocions", "promocions", name: "formadepagos_promocions_promocion_id_fk", dependent: :delete

  add_foreign_key "foto_impuesto_recs", "renglon_recdetalles", name: "foto_impuesto_recs_renglon_recdetalle_id_fk"

  add_foreign_key "impresiones_facts", "facturas", name: "impresiones_facts_factura_id_fk", dependent: :delete

  add_foreign_key "impresiones_ndcs", "notadecreditos", name: "impresiones_ndcs_notadecredito_id_fk", dependent: :delete

  add_foreign_key "impresiones_ndds", "notadedebitos", name: "impresiones_ndds_notadedebito_id_fk", dependent: :delete

  add_foreign_key "impresiones_recs", "recibos", name: "impresiones_recs_recibo_id_fk", dependent: :delete

  add_foreign_key "impuestos_renglon_factdetalles", "impuestos", name: "impuestos_renglon_factdetalles_impuesto_id_fk"
  add_foreign_key "impuestos_renglon_factdetalles", "renglon_factdetalles", name: "impuestos_renglon_factdetalles_renglon_factdetalle_id_fk", dependent: :delete

  add_foreign_key "impuestos_renglon_ndcdetalles", "impuestos", name: "impuestos_renglon_ndcdetalles_impuesto_id_fk"
  add_foreign_key "impuestos_renglon_ndcdetalles", "renglon_ndcdetalles", name: "impuestos_renglon_ndcdetalles_renglon_ndcdetalle_id_fk", dependent: :delete

  add_foreign_key "impuestos_renglon_ndddetalles", "impuestos", name: "impuestos_renglon_ndddetalles_impuesto_id_fk"
  add_foreign_key "impuestos_renglon_ndddetalles", "renglon_ndddetalles", name: "impuestos_renglon_ndddetalles_renglon_ndddetalle_id_fk", dependent: :delete

  add_foreign_key "impuestos_renglon_recdetalles", "impuestos", name: "impuestos_renglon_recdetalles_impuesto_id_fk"
  add_foreign_key "impuestos_renglon_recdetalles", "renglon_recdetalles", name: "impuestos_renglon_recdetalles_renglon_recdetalle_id_fk", dependent: :delete

  add_foreign_key "notadecreditos", "sucursals", name: "notadecreditos_sucursal_id_fk"

  add_foreign_key "notadedebitos", "sucursals", name: "notadedebitos_sucursal_id_fk"

  add_foreign_key "precioarts", "listaprecios", name: "precioarts_listaprecio_id_fk", dependent: :delete
  add_foreign_key "precioarts", "rolarticulos", name: "precioarts_comercializable_id_fk", column: "comercializable_id"

  add_foreign_key "recibos", "formadepagos", name: "recibos_pagocontado_id_fk", column: "pagocontado_id"
  add_foreign_key "recibos", "monedas", name: "recibos_moneda_id_fk"
  add_foreign_key "recibos", "sucursals", name: "recibos_sucursal_id_fk"

  add_foreign_key "renglon_factdetalles", "facturas", name: "renglon_factdetalles_factura_id_fk"

  add_foreign_key "renglon_facturas", "facturas", name: "renglon_facturas_factura_id_fk", dependent: :delete
  add_foreign_key "renglon_facturas", "rolarticulos", name: "renglon_facturas_comercializable_id_fk", column: "comercializable_id"

  add_foreign_key "renglon_ndc_articulos", "notadecreditos", name: "renglon_ndc_articulos_notadecredito_id_fk", dependent: :delete
  add_foreign_key "renglon_ndc_articulos", "rolarticulos", name: "renglon_ndc_articulos_comercializable_id_fk", column: "comercializable_id"

  add_foreign_key "renglon_ndcdetalles", "facturas", name: "renglon_ndcdetalles_factura_id_fk"
  add_foreign_key "renglon_ndcdetalles", "notadecreditos", name: "renglon_ndcdetalles_notadecredito_id_fk", dependent: :delete

  add_foreign_key "renglon_ndcndds", "notadecreditos", name: "renglon_ndcndds_notadecredito_id_fk", dependent: :delete
  add_foreign_key "renglon_ndcndds", "notadedebitos", name: "renglon_ndcndds_notadedebito_id_fk"

  add_foreign_key "renglon_ndd_articulos", "notadedebitos", name: "renglon_ndd_articulos_notadedebito_id_fk", dependent: :delete
  add_foreign_key "renglon_ndd_articulos", "rolarticulos", name: "renglon_ndd_articulos_comercializable_id_fk", column: "comercializable_id"

  add_foreign_key "renglon_ndddetalles", "facturas", name: "renglon_ndddetalles_factura_id_fk"
  add_foreign_key "renglon_ndddetalles", "notadedebitos", name: "renglon_ndddetalles_notadedebito_id_fk", dependent: :delete

  add_foreign_key "renglon_nddndcs", "notadecreditos", name: "renglon_nddndcs_notadecredito_id_fk"
  add_foreign_key "renglon_nddndcs", "notadedebitos", name: "renglon_nddndcs_notadedebito_id_fk", dependent: :delete

  add_foreign_key "renglon_notacreditos", "facturas", name: "renglon_notacreditos_factura_id_fk"
  add_foreign_key "renglon_notacreditos", "notadecreditos", name: "renglon_notacreditos_notadecredito_id_fk", dependent: :delete
  add_foreign_key "renglon_notacreditos", "rolarticulos", name: "renglon_notacreditos_comercializable_id_fk", column: "comercializable_id"

  add_foreign_key "renglon_notadebitos", "facturas", name: "renglon_notadebitos_factura_id_fk"
  add_foreign_key "renglon_notadebitos", "notadedebitos", name: "renglon_notadebitos_notadedebito_id_fk", dependent: :delete
  add_foreign_key "renglon_notadebitos", "rolarticulos", name: "renglon_notadebitos_comercializable_id_fk", column: "comercializable_id"

  add_foreign_key "renglon_recdetalles", "facturas", name: "renglon_recdetalles_factura_id_fk"
  add_foreign_key "renglon_recdetalles", "recibos", name: "renglon_recdetalles_recibo_id_fk"

  add_foreign_key "renglon_recibo_docs", "recibos", name: "renglon_recibo_docs_recibo_id_fk", dependent: :delete

  add_foreign_key "renglon_recibos", "facturas", name: "renglon_recibos_factura_id_fk"

  add_foreign_key "sucursals", "clientes", name: "sucursals_empresa_id_fk", column: "empresa_id", dependent: :delete

end
