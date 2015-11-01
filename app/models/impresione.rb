# == Schema Information
#
# Table name: impresiones
#
#  id              :integer          not null, primary key
#  anulada         :boolean          default(FALSE)
#  cant_paginas    :integer          default(1)
#  imprimible_id   :integer          not null
#  imprimible_type :string(255)      not null
#  contado         :boolean
#  numero          :integer          not null
#  serie           :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Impresione < ActiveRecord::Base

  belongs_to :imprimible, :polymorphic => true

  private

  alfa_reg = /[A-Z]/i

  validates :numero, :numericality => {:message => "Debe ingresar un numero valido."}
  validates :serie, :format => { :with => alfa_reg,:message => "Debe ingresar una letra como serie." }

  def self.proximo_preimpreso()
    ##mperez 22/06/2014 mantis 304
    #@serie = Impresione.maximum(:serie)
    @id = Impresione.maximum(:id)
    if @id
      #@nro = Impresione.where(:serie => @serie).maximum(:numero)
      #@nro = Impresione.where(:serie => @serie).maximum(:id)
      #@imp = Impresione.find(:first, :conditions => {:serie => @serie,:numero => @nro})
      @imp = Impresione.find(:first, :conditions => {:id => @id})
      @serie = @imp.serie
      if @imp.numero + @imp.cant_paginas >= 999999
        @serie = @imp.serie.next
        if @serie.eql?("Z")
          @serie = "A"
        end
        @nro = (@imp.numero + @imp.cant_paginas*2).modulo( 999999 )
      else
        @nro = @imp.numero + @imp.cant_paginas*2
      end
    else
      @serie = "A"
      @nro = 1
    end

    return [@serie,@nro]

  end

end
