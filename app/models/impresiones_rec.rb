# == Schema Information
#
# Table name: impresiones_recs
#
#  id           :integer          not null, primary key
#  numero       :integer          not null
#  serie        :string(255)      not null
#  anulada      :boolean          default(FALSE)
#  cant_paginas :integer          default(1)
#  recibo_id    :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ImpresionesRec < ActiveRecord::Base
  belongs_to :recibo

  private

  alfa_reg = /[A-Z]/i

  validates :numero, :numericality => {:message => "Debe ingresar un numero valido."}
  validates :serie, :format => { :with => alfa_reg,:message => "Debe ingresar una letra como serie." }

  def self.proximo_preimpreso()
    @imp = ImpresionesRec.last
    if !@imp.nil?
      if @imp.numero + @imp.cant_paginas >= 999999
        @serie = @imp.serie.next
        if @serie.eql?("Z")
          @serie = "A"
        end
        @nro = (@imp.numero + @imp.cant_paginas).modulo( 999999 )
      else
        @serie = @imp.serie
        @nro = @imp.numero + @imp.cant_paginas
      end
    else
      @serie = "A"
      @nro = 1
    end

    return [@serie,@nro]

  end

end
